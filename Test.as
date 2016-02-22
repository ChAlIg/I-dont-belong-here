package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Test extends MovieClip {
		var m: SS;
		var list: Array = [];
		var distlist: Vector.<Number>;
		var t: Number;
		var i: int;
		var j: int;
		public function Test() {
			distlist = new Vector.<Number>();
			for (i = 0; i < 10000; ++i) {
				distlist.push(0);
			}
			for (i = 0; i < 10; ++i) {
				for (j = 0; j < 10; ++j) {
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
			for (i = 0; i < 100; ++i) {
				for (j = 0; j < 100; ++j) {
					t = dist(list[i], list[j]);
					if (5 < t) {
						distlist[i+j*10] = t;
					}
				}
			}
			/*for (var i: int = 0; i < 100; ++i) {
				for (var j: int = i; j < 100; ++j) {
					list[j].hitTestPoint(list[i].x, list[i].y, true);
				}
			}*/
		}
		function dist(left:*, right:*):Number {
			return Math.sqrt((left.x - right.x)^2 + (left.y-right.y)^2);
		}

	}
	
}
