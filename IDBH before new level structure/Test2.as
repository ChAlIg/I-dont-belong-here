package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Test2 extends MovieClip {
		var m: SS;
		var list: Array = [];
		var distlist: Vector.<Number>;
		var t: Number;
		var i: int;
		var j: int;
		public function Test2() {
			for (i = 0; i < 100; ++i) {
				for (j = 0; j < 100; ++j) {
					m = new SS();
					m.x = i*40+j*2;
					m.y = j*30+i*3;
					addChild(m);
					list.push(m);
				}
			}
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
		function loop (e: Event):void {
			for (i = 0; i < 10000; ++i) {
				list[i].loop();
			}
			/*for (var i: int = 0; i < 100; ++i) {
				for (var j: int = i; j < 100; ++j) {
					list[j].hitTestPoint(list[i].x, list[i].y, true);
				}
			}*/
		}
		function dist(x1:Number, y1:Number, x2:Number, y2:Number):Number {
			return Math.sqrt((x1-x2)^2 + (y1-y2)^2);
		}

	}
	
}
