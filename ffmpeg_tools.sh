#!/usr/bin/env bash
# أدوات ffmpeg لسير العمل. الاستخدام: ./ffmpeg_tools.sh <أمر> [وسائط]
set -euo pipefail

usage() {
cat <<'EOF'
الأوامر:
  trim     <in> <start> <end> <out>    قص مقطع (مثال: 00:00:03 00:00:08)
  concat   <out> <in1> <in2> ...       دمج مقاطع بنفس الإعدادات
  addaudio <video> <audio> <out>       استبدال/إضافة مسار صوت للفيديو
  mix      <video> <music> <out> [vol] دمج موسيقى خلفية مع صوت الفيديو (vol=0.25)
  to169    <in> <out>                  تحويل إلى 1920x1080 مع حواف سوداء
  to916    <in> <out>                  تحويل إلى 1080x1920 (عمودي)
  gif      <in> <out>                  معاينة GIF سريعة
  loudnorm <in> <out>                  تطبيع الصوت إلى -14 LUFS
  subs     <video> <srt> <out>         حرق ترجمة داخل الفيديو
EOF
}

need() { command -v ffmpeg >/dev/null || { echo "ffmpeg غير مثبت" >&2; exit 1; }; }
need

cmd="${1:-}"; shift || true
case "$cmd" in
  trim)     ffmpeg -y -i "$1" -ss "$2" -to "$3" -c:v libx264 -preset veryfast -crf 18 -c:a aac "$4" ;;
  concat)
    out="$1"; shift
    list=$(mktemp)
    for f in "$@"; do echo "file '$(realpath "$f")'" >> "$list"; done
    ffmpeg -y -f concat -safe 0 -i "$list" -c:v libx264 -preset veryfast -crf 18 -c:a aac "$out"
    rm -f "$list" ;;
  addaudio) ffmpeg -y -i "$1" -i "$2" -map 0:v -map 1:a -c:v copy -c:a aac -shortest "$3" ;;
  mix)
    vol="${4:-0.25}"
    ffmpeg -y -i "$1" -i "$2" -filter_complex \
      "[1:a]volume=${vol}[m];[0:a][m]amix=inputs=2:duration=first[a]" \
      -map 0:v -map "[a]" -c:v copy -c:a aac "$3" ;;
  to169)    ffmpeg -y -i "$1" -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2" -c:v libx264 -preset veryfast -crf 18 -c:a aac "$2" ;;
  to916)    ffmpeg -y -i "$1" -vf "scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920" -c:v libx264 -preset veryfast -crf 18 -c:a aac "$2" ;;
  gif)      ffmpeg -y -i "$1" -vf "fps=12,scale=480:-1" "$2" ;;
  loudnorm) ffmpeg -y -i "$1" -af loudnorm=I=-14:TP=-1.5:LRA=11 -c:v copy "$2" ;;
  subs)     ffmpeg -y -i "$1" -vf "subtitles=$2" -c:a copy "$3" ;;
  *)        usage; exit 1 ;;
esac
