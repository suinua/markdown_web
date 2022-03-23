from PIL import Image, ImageDraw, ImageFont
import sys

if __name__ == '__main__':
    args = sys.argv

    font_size = 60
    text = args[1]
    fileName = args[2]
    assets_dir = args[3]

    img = Image.open(assets_dir + 'thumbnail.png')
    draw = ImageDraw.Draw(img)
    font = ImageFont.truetype(assets_dir + 'NotoSerifJP-Regular.otf', font_size)
    MAX_W, MAX_H = img.width, img.height

    index = 0
    line = 0
    now_width = 0
    now_text = ""
    for char in text:
        now_text += char
        font_width, font_height = font.getsize(char)
        now_width += font_width
        if now_width >= MAX_W - 100:
            w, h = draw.textsize(now_text, font=font)
            draw.text(((MAX_W - w)/2, MAX_H / 2 + (line * 70) - 80), now_text, fill="black", font=font)
            now_text = ""
            now_width = 0
            line += 1
        elif index == len(text)-1:
            w, h = draw.textsize(now_text, font=font)
            draw.text(((MAX_W - w) / 2, MAX_H / 2 + (line * 70) - 80), now_text, fill="black", font=font)
        index += 1

    img.save(fileName + ".png")
    print("save image : " + fileName + ".png")
