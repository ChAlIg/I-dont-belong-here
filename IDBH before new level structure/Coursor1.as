package {

	import flash.display.MovieClip;

	public class Coursor1 extends MovieClip {

		var number: Number;
		var player: Player1;

		public function Coursor1(X: int, Y: int, thePlayer:Player1) {
			x = X;
			y = Y;
			c2.alpha = 0;
			c3.alpha = 0;
			player = thePlayer;
		}
		public function moving(dy: Number) {
			y += dy;
			if (y > 510)
				y = 510;
			else if (y < 30)
				y = 30;

			scaleX = scaleY = 2 - (y - 30) / 480;

			number = y - 410;
			if (number < 0)
				number = 0;
			else if (number > 100)
				number = 100;
			c1.alpha = number / 100;
			number = 100 - Math.abs(y - 350);
			if (number < 0)
				number = 0;
			c2.alpha = number / 100;
			number = 100 - Math.abs(y - 190);
			if (number < 0)
				number = 0;
			c3.alpha = number / 100;
		}

	}

}