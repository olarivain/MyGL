varying lowp vec4 DestinationColor;

void main(void) {
    float gray = 0.5 //or some other values
	gl_FragColor = vec4(gray,gray,gray,1.0);
}