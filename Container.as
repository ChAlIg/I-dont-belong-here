package  {
	
	import flash.display.Sprite;
	
	public class Container extends Sprite {
		public var unitList: Array = [];
		public var bulletList: Array = [];
		public var loop_order: int = 20;
		var i: int;

		public function Container() {
			// constructor code
		}
		
		public function loop(): void {
			if (loop_order) {
				--loop_order;
			} else {
				loop_order = 20;
			}
			for (i = unitList.length - 1; i >= 0; --i) //for each one
			{
				unitList[i].loop();
				if (unitList[i].death) {
					unitList[i].destroy();
					unitList.splice(i, 1);
				}
			}
			
			for (i = bulletList.length - 1; i >= 0; --i) //for each one
			{
				bulletList[i].loop();
				if (bulletList[i].death) {
					bulletList[i].destroy();
					bulletList.splice(i, 1);
				}
			}
		}

	}
	
}
