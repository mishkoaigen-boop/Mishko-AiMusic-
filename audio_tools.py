#!/usr/bin/env python3
"""أدوات صوت بسيطة بدون مكتبات خارجية (ffprobe/ffmpeg فقط).

الاستخدام:
  python3 audio_tools.py info  <ملف>          مدة وصيغة ومعدل العينة
  python3 audio_tools.py loud  <ملف>          قياس مستوى الصوت (LUFS)
  python3 audio_tools.py norm  <دخل> <خرج>    تطبيع إلى -14 LUFS
  python3 audio_tools.py scan  <مجلد>         فحص كل ملفات الصوت/الفيديو في مجلد
"""
import json
import subprocess
import sys
from pathlib import Path

EXTS = {".wav", ".mp3", ".flac", ".m4a", ".aac", ".ogg", ".mp4", ".mov", ".mkv"}


def run(cmd):
    return subprocess.run(cmd, capture_output=True, text=True)


def info(path):
    r = run(["ffprobe", "-v", "error", "-show_format", "-show_streams",
             "-of", "json", str(path)])
    if r.returncode != 0:
        return {"file": str(path), "error": r.stderr.strip()}
    d = json.loads(r.stdout)
    audio = next((s for s in d.get("streams", []) if s["codec_type"] == "audio"), {})
    return {
        "file": str(path),
        "duration_s": round(float(d["format"].get("duration", 0)), 2),
        "codec": audio.get("codec_name"),
        "sample_rate": audio.get("sample_rate"),
        "channels": audio.get("channels"),
    }


def loudness(path):
    r = run(["ffmpeg", "-i", str(path), "-af", "loudnorm=print_format=json",
             "-f", "null", "-"])
    start = r.stderr.rfind("{")
    return json.loads(r.stderr[start:]) if start != -1 else {"error": "تعذر القياس"}


def main():
    if len(sys.argv) < 3:
        print(__doc__)
        sys.exit(1)
    cmd, arg = sys.argv[1], sys.argv[2]
    if cmd == "info":
        print(json.dumps(info(arg), ensure_ascii=False, indent=2))
    elif cmd == "loud":
        print(json.dumps(loudness(arg), indent=2))
    elif cmd == "norm" and len(sys.argv) == 4:
        r = run(["ffmpeg", "-y", "-i", arg, "-af",
                 "loudnorm=I=-14:TP=-1.5:LRA=11", sys.argv[3]])
        print("تم" if r.returncode == 0 else r.stderr[-500:])
    elif cmd == "scan":
        for p in sorted(Path(arg).rglob("*")):
            if p.suffix.lower() in EXTS:
                print(json.dumps(info(p), ensure_ascii=False))
    else:
        print(__doc__)
        sys.exit(1)


if __name__ == "__main__":
    main()
