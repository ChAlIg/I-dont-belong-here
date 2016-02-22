package  {
	
	import flash.display.Sprite;
	
	public class Container extends Sprite {
		public var unitList: Array = [];
		public var bulletList: Array = [];
		var i: int;

		public function Container() {
			// constructor code
		}
		
		public function loop(): void {
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
