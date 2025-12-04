# Keyboard

A low-profile split keyboard with 56 hotswappable, RGB backlit keys. Powered by an ESP32-S3.

This is the first project I'm trying to get a PCB manufactured for. I've polished the design up to a point I'm happy with, but there might be mistakes.

The directory structure should be self-explanatory. Currently, `firmare/` only contains a blink program. I'm still deciding whether I should try porting ZMK (ESP32-S3 requires some work) or writing my own firmware from scratch. The latter option would give me more freedom to experiment with the hardware (I have some unconventional ideas), so I'm leaning towards that.

The BOM does not contain anything for the housing or keycaps, as I intend to resin-print those myself.

**Schematic:**
![Schematic](src/schematic.png)

**PCB:**
![Front](src/pcb-front.png)
![Back](src/pcb-back.png)

**Housing:**
![Housing](src/housing_full.png)
![Housing (left side)](src/housing_left_back.png)
![Housing with keycaps](src/housing-keycaps.png)

**Keycaps:**
![Keycap (top angle)](src/keycap-a.png)
![Keycap (bottom angle)](src/keycap-b.png)