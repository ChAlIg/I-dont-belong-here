package  {
	import flash.display.MovieClip;
	
	public class MyRectangle extends MovieClip {

		public function MyRectangle(X: int, Y: int, w:int, h: int, color: uint = 0x99CC66) {
			graphics.beginFill(color);
			graphics.drawRect(X-w/2, Y-h/2, w, h);
		}

	}
	
}
