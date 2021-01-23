import nimgl/opengl

type
  VertexBufferElement* = object
    `type`*: GLenum
    count*: int32
    normalized*: bool

  VertexBufferLayout* = ref object
    elements*: seq[VertexBufferElement]
    stride*: int32

proc getSizeOfType*(element: VertexBufferElement): int32 =
  case element.`type`:
    of EGL_FLOAT: 4
    of GL_UNSIGNED_INT: 4
    of GL_UNSIGNED_BYTE: 1
    else: raise newException(Defect, "Unsupported type: " & $element.`type`.uint32)

proc add*(layout: VertexBufferLayout, `type`: GLenum, count: int32) =
  let element = case `type`:
    of EGL_FLOAT: VertexBufferElement(`type`: `type`, count: count, normalized: true)
    of GL_UNSIGNED_INT: VertexBufferElement(`type`: `type`, count: count, normalized: true)
    of GL_UNSIGNED_BYTE: VertexBufferElement(`type`: `type`, count: count, normalized: false)
    else: raise newException(Defect, "Unsupported type: " & $`type`.uint32)

  layout.elements.add(element)
  layout.stride += count * element.getSizeOfType