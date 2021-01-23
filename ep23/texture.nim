import nimgl/opengl
import ../vendor/stb_image/read as stbi
import index_buffer, shader, vertex_array

type
  Texture* = ref object
    rendererId*: uint32
    filepath*: string
    localBuffer*: seq[byte]
    width*: int
    height*: int
    bpp*: int

proc `=destroy`*(texture: var typeof(Texture()[])) =
  glDeleteTextures(1, texture.rendererId.addr)

proc newTexture*(filepath: string): Texture =
  result = Texture(filepath: filepath)
  stbi.setFlipVerticallyOnLoad(true)
  result.localBuffer = stbi.load(filepath, result.width, result.height, result.bpp, 4)

  glGenTextures(1, result.rendererId.addr)
  glBindTexture(GL_TEXTURE_2D, result.rendererId)

  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR.int32)
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR.int32)
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE.int32)
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE.int32)

  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA8.int32, result.width.int32, result.height.int32, 0,
               GL_RGBA, GL_UNSIGNED_BYTE, result.localBuffer[0].addr)
  glBindTexture(GL_TEXTURE_2D, 0)

  result.localBuffer = @[]

proc `bind`*(texture: Texture, slot: uint32 = 0) =
  glActiveTexture(GLenum(GL_TEXTURE0.ord + slot))
  glBindTexture(GL_TEXTURE_2D, texture.rendererId)

proc unbind*(texture: Texture) =
  glBindTexture(GL_TEXTURE_2D, 0)
