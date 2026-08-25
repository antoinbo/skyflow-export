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
      - id: unknown0000
        contents: [0, 0, 0, 0]
      - id: timestamp
        type: f8
      - id: params
        type: f4
        repeat: expr
        repeat-expr: 10
