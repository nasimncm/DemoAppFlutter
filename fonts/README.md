# Fonts Folder

Yahan aap apni font files add karein.

## Steps to Add Fonts:

1. **Font files yahan add karein:**
   - `CustomFont-Regular.ttf` (weight: 400)
   - `CustomFont-Medium.ttf` (weight: 500)
   - `CustomFont-SemiBold.ttf` (weight: 600)
   - `CustomFont-Bold.ttf` (weight: 700)

2. **Font family name update karein:**
   - `lib/constants/fonts.dart` file mein `CustomFont` ko apne font ke actual name se replace karein
   - `pubspec.yaml` file mein bhi `CustomFont` ko apne font ke actual name se replace karein

3. **Font file names update karein:**
   - `pubspec.yaml` file mein font file names ko apne actual file names se replace karein

4. **Run command:**
   ```bash
   flutter pub get
   ```

## Example:

Agar aapka font name "Poppins" hai, to:
- Font files: `Poppins-Regular.ttf`, `Poppins-Medium.ttf`, etc.
- `lib/constants/fonts.dart` mein: `static const String fontFamily = 'Poppins';`
- `pubspec.yaml` mein: `family: Poppins`

## Note:
- Font file names case-sensitive hote hain
- Font family name exactly wahi hona chahiye jo font file ke andar defined hai
- Agar aapke paas sirf ek font file hai, to sirf wahi add karein
