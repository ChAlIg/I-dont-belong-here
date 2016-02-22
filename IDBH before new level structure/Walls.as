package {
	import flash.display.Stage;
	import flash.display.MovieClip;

	public class Walls extends MovieClip {
		
		//public var buildList: Array = [];
		//public var building: Building_1;
		public var level: Level;
		public var game: Game;
		
		var i: int;

		public function Walls(main: Game, where: Level, X: int, Y: int): void {
			this.x = X;
			this.y = Y;
			level = where;
			game = main;
			//building = new Building_1 (game, level, this, 12, 83);
			//addChild(building);
			//buildList.push(building);
		}
		public function loop(): void {
			//for (i = buildList.length - 1; i >= 0; --i) //for each one
			//{
			//	buildList[i].loop();
			//}
		}

	}

}