varying highp vec4 colorInterp;
varying highp vec2 texturePosInterp;

uniform sampler2D textureUnit;

void main()
{
    gl_FragColor = texture2D(textureUnit, texturePosInterp);
}
