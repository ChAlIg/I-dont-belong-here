package {

	import flash.display.MovieClip;

	public class Coursor2 extends MovieClip {

		var number: Number;
		var player: Player2;

		public function Coursor2(X: int, Y: int, thePlayer:Player2) {
			x = X;
			y = Y;
			player = thePlayer;
		}
		
		public function moving(dx:Number, dy: Number) {
			if (x+dx > 800)
				x = 800;
			else if (x+dx < 0)
				x = 0;
			else
				x += dx;
			
			if (y+dy > 600)
				y = 600;
			else if (y+dy < 0)
				y = 0;
			else
				y += dy;
			rotation = player.rotation;
		}

	}

}