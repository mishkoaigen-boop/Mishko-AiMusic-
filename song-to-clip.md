# من الفكرة للأغنية للكليب

1. **Brief**: املا `templates/music-brief.md` (فكرة، مزاج، نوع، مرجع صوتي بالوصف).
2. **كلمات**: skill `egyptian-lyrics` → 3 هوكات، اختيار، كتابة كاملة.
3. **Suno**: skill `suno-prompting` → style + lyrics tags؛ توليد 3-5 نسخ.
4. **اختيار وتحسين**: اسمع، اختار، عدّل كلمة/ستايل، أعد التوليد.
5. **توزيع اختياري**: skill `fl-studio-arrangement` لو عايز تعيد التوزيع أو تضيف طبقات.
6. **كليب**: قسّم الأغنية لمقاطع (فيرس/هوك/بريدج) → character bible → shot list → skill `video-prompting`.
7. **مونتاج**: ركّب اللقطات على الإيقاع، قص عند الـ downbeat.
8. **تصدير**: نسخ طولية للريلز ونسخة عرضية لليوتيوب.

> بعد المونتاج: `scripts/audio_tools.py loud <ملف>` للقياس و`scripts/ffmpeg_tools.sh loudnorm` للتطبيع إلى -14 LUFS.
