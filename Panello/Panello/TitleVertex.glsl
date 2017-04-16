attribute vec2 position;
attribute vec4 color;
uniform vec2 translation;
varying vec4 colorInterp;
attribute vec2 texturePos;
varying vec2 texturePosInterp;


void main()
{
    gl_Position = vec4(position.x + translation.x, position.y + translation.y, 0.0, 1.0);
    colorInterp = color;
    texturePosInterp = texturePos;
}
