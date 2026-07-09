import os,sys
from PIL import Image, ImageDraw, ImageFont

out = sys.argv[1] if len(sys.argv)>1 else "zhuanzhuan-backend/uploads/products"
data_file = sys.argv[2] if len(sys.argv)>2 else "products.txt"
os.makedirs(out, exist_ok=True)

colors = {'7':("#2D6A4F","PHONE"),'8':("#1B4332","LAPTOP"),'9':("#40916C","TABLET"),
    '10':("#1565C0","AUDIO"),'11':("#E65100","CAMERA"),'12':("#455A64","GADGET"),
    '13':("#7B1FA2","BOOK"),'14':("#C62828","NOVEL"),'15':("#0277BD","SCIENCE"),
    '16':("#F57F17","EXAM"),'17':("#2E7D32","DORM"),'18':("#BF360C","COOK"),
    '19':("#C2185B","BEAUTY"),'20':("#1565C0","TOP"),'21':("#37474F","PANTS"),
    '22':("#00695C","SHOES"),'23':("#BF360C","BAG"),'24':("#E65100","SPORT"),
    '25':("#4E342E","CAMP"),'6':("#546E7A","OTHER")}

products = []
with open(data_file, 'r', encoding='utf-8') as f:
    for line in f:
        parts = line.strip().split('\t')
        if len(parts)>=3: products.append((int(parts[0]), parts[1], parts[2]))

fonts = []
for f in ["C:/Windows/Fonts/msyh.ttc","C:/Windows/Fonts/simhei.ttf","C:/Windows/Fonts/arial.ttf"]:
    try: fonts.append(ImageFont.truetype(f,36)); break
    except: pass
if not fonts: fonts.append(ImageFont.load_default())
font = fonts[0]

for pid,title,cat_id in products:
    c,label = colors.get(str(cat_id),("#546E7A","ITEM"))
    rgb = tuple(int(c[i:i+2],16) for i in (1,3,5))
    img = Image.new('RGB',(640,480),rgb)
    d = ImageDraw.Draw(img)
    # Stripes
    for x in range(0,640,40): d.rectangle((x,0,x+20,480),fill=tuple(max(0,v-25) for v in rgb))
    # Label
    d.text((320,120),label,fill=(255,255,255,200),anchor="mm",font=font)
    # Title - truncate or wrap
    t = title[:20] if len(title)>20 else title
    d.text((320,240),t,fill="white",anchor="mm",font=font)
    d.text((320,360),"转转",fill=(255,255,255,100),anchor="mm",font=font)
    img.save(f"{out}/{pid}.jpg",quality=90)

print(f"Generated {len(products)} images in {out}")
