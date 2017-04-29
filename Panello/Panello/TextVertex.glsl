attribute vec2 position;
attribute vec2 texturePos;
uniform vec2 translation;
uniform vec2 scale;
varying vec2 texturePosInterp;

void main()
{
    gl_Position = vec4((position.x * scale.x) + translation.x, (position.y * scale.y) + translation.y, 0.0, 1.0);
    texturePosInterp = texturePos;
}
