attribute vec2 position;
uniform vec2 translation;
attribute vec2 texturePos;
varying vec2 texturePosInterp;


void main()
{
    gl_Position = vec4(position.x + translation.x, position.y + translation.y, 0.0, 1.0);
    texturePosInterp = texturePos;
}
