# ----------------------------------------------------------------------------
# main.py: driver program for the christmas-box.
#
# The program displays the listed images and plays the given mp3.
# Images and sound-files should be in directory ./media
# Note that the mp3-files should be 8k-mono, while the image-files should
# be 160x128 BMPs.
#
# Author: Bernhard Bablok
# License: GPL3
#
# Website: https://github.com/bablokb/christmas-box
#
# ----------------------------------------------------------------------------

import board
import time
import busio
import displayio

from adafruit_st7735r import ST7735R       # SPI-TFT  display

import audiomp3
import audiopwmio

# --- constants - adapt to your needs!   -------------------------------------

PIN_CS   = board.GP22
PIN_RST  = board.GP21
PIN_DC   = board.GP20   # A0 on some displays
PIN_MOSI = board.GP19   # SDA
PIN_CLK  = board.GP18   # SCK
PIN_PWM  = board.GP17   # AIN+ on PAM8302A

TFT_WIDTH  = 160
TFT_HEIGHT = 128
TFT_ROTATE =  90
TFT_BGR    = True

IMG_FILES = [
  'stern-von-bethlehem.bmp',
  'kugel+kerze.bmp',
  'blauer-stern.bmp'
  ]

SND_FILES = [
  'stille-nacht.mp3',
  'o-tannenbaum.mp3'
  ]

# --- create display   -------------------------------------------------------

displayio.release_displays()

spi     = busio.SPI(clock=PIN_CLK,MOSI=PIN_MOSI)
bus     = displayio.FourWire(spi,command=PIN_DC,chip_select=PIN_CS,
                         reset=PIN_RST)
display = ST7735R(bus,width=TFT_WIDTH,height=TFT_HEIGHT,
                 rotation=TFT_ROTATE,bgr=TFT_BGR)
display.auto_refresh = False

group = displayio.Group()

# --- update image   ---------------------------------------------------------

def upd_image(img):
  img_file = open("./media/"+img, "rb")
  bmp  = displayio.OnDiskBitmap(img_file)
  tile = displayio.TileGrid(bmp,pixel_shader=displayio.ColorConverter())
 
  if len(group) == 1:
    del group[0]
  group.append(tile)
  display.show(group)
  display.refresh()

# --- main loop   ------------------------------------------------------------

audio   = audiopwmio.PWMAudioOut(PIN_PWM)
decoder = audiomp3.MP3Decoder(open("./media/"+SND_FILES[0], "rb"))

upd_image(IMG_FILES[-1])

while True:
  for snd in SND_FILES:
    # play current sound-file
    decoder.file = open("./media/"+snd, "rb")
    audio.play(decoder)

    # show images while playing
    while audio.playing:
      for img in IMG_FILES:
        time.sleep(5)
        upd_image(img)

    # close sound-file
    decoder.file.close()
