meta:
  id: skyflow
  file-extension: dat
  endian: le
seq:
  - id: header
    type: u4
  - id: frames
    type: frame
    repeat: eos
types:
  frame:
    seq:
      - id: index
        type: u4
      - id: unknown0x00000000
        contents: [0, 0, 0, 0]
      - id: timestamp
        type: f8
      - id: interval
        type: f4
      - id: unknown10_100
        contents: [
          0x00, 0x00, 0x80, 0x3f, #  1
          0x00, 0x00, 0x00, 0x00, #  0
          0x00, 0x00, 0x80, 0xbf, # -1
          0x00, 0x00, 0x00, 0x00, #  0
          0x00, 0x00, 0x00, 0x00, #  0
        ]
      - id: params
        type: f4
        repeat: expr
        repeat-expr: 3
      - id: unknown0x46ca923f
        contents: [0x46, 0xca, 0x92, 0x3f]
