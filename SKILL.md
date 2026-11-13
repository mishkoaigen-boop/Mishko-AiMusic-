---
name: suno-prompting
description: حوّل كلمات وفكرة أغنية لبرومبت ستايل وبنية جاهزين للصق في Suno، مع نصائح للعربي والعامية المصرية.
---

# برومبتات Suno

## المخرج المطلوب دايمًا
1. **Style prompt** (إنجليزي، سطر واحد مركّز): النوع، المزاج، الإيقاع، الآلات، نوع الصوت.
2. **Lyrics مع tags** بين أقواس مربعة.
3. **Exclude** (اختياري): اللي مش عايزه.

## قالب Style
`[genre/subgenre], [mood], [BPM range], [key instruments], [vocal type/gender/tone], [production notes]`

أمثلة اتجاهات:
- تراب مصري: `Egyptian Arabic trap, dark melancholic, 140 BPM, 808 bass, oud sample, male raspy vocal, spacious reverb`
- نوبي: `Nubian folk, warm, 90 BPM, daf, oud, female lead with group chorus, acoustic`
- أم/عاطفي: `Arabic emotional ballad, 70 BPM, piano, strings, qanun, soulful female vocal`

## Tags للبنية
`[Intro] [Verse] [Pre-Chorus] [Chorus] [Bridge] [Outro]` وللصوت: `[Whispered] [Spoken] [Choir]`.
- الهوك = Chorus، سطوره قصيرة ومتكررة.
- الـ Bridge يتحط قبل آخر Chorus ويغيّر الإيقاع أو الكثافة.

## نصائح للعربي
- اكتب الكلمات بالحروف العربية؛ لو النطق بيتلخبط جرّب كتابة تشكيل خفيف على الكلمة المشكلة.
- جمل قصيرة بتتنطق أحسن من الطويلة.
- ولّد أكتر من نسخة (3-5) واختار؛ غيّر كلمة واحدة في الستايل كل مرة بدل تغيير كل حاجة.
- لا تذكر أسماء فنانين حقيقيين في الستايل؛ صِف الصوت والجو.
