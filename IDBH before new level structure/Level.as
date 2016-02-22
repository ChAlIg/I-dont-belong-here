package {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import flash.geom.Matrix;
	import flash.geom.Point;

	public class Level extends MovieClip {
		public var game: Game;
		public var walls: Walls;
		public var info: Info;
		public var building_1: Building_1;
		public var player1: Player1;
		public var player2: Player2;

		public var point: Point;
		private var i: int;
		private var j: int;
		
		public var loop_order: int = 20;
		
		public var bulletList: Array = [];
		public var unitList: Array = [];
		public var layerList: Vector.<Container> = new Vector.<Container>();

		public function Level(main:Game, content:String): void {
			game = main;
			
			var t: Container;
			for (i = 0; i < 7; ++i) {
				t = new Container();
				addChild(t);
				layerList.push(t);
			}
			
			var pale_1: Pale_1;
			var trash: Trash;
			
			
			walls = new Walls(game, this, 0, 0);
			addChild(walls);
			trash = new Trash(game, this, 320, 240);
			addChild(trash);
			unitList.push(trash);
			trash = new Trash(game, this, 234, 556);
			addChild(trash);
			unitList.push(trash);
			trash = new Trash(game, this, 34, 766);
			addChild(trash);
			unitList.push(trash);
			trash = new Trash(game, this, 457, 23);
			addChild(trash);
			unitList.push(trash);
			trash = new Trash(game, this, 345, 423);
			addChild(trash);
			unitList.push(trash);
			trash = new Trash(game, this, 264, 567);
			addChild(trash);
			unitList.push(trash);
			trash = new Trash(game, this, 32, 43);
			addChild(trash);
			unitList.push(trash);
			trash = new Trash(game, this, 123, 123);
			addChild(trash);
			unitList.push(trash);
			trash = new Trash(game, this, 400, 550);
			addChild(trash);
			unitList.push(trash);
			for (i = 0; i <=800; i += 200) {
				for (j = 0; j <= 600; j += 200) {
					trash = new Trash(game, this, i, j);
					addChild(trash);
					unitList.push(trash);
				}
			}
			player1 = new Player1(game, this);
			addChild(player1);
			unitList.push(player1);
			player2 = new Player2(game, this);
			addChild(player2);
			unitList.push(player2);
			game.playerList.push(player1, player2);
			info = new Info(0, 0);
			addChild(info);
			pale_1 = new Pale_1 (game, this, 900, 300);
			addChild(pale_1);
			unitList.push(pale_1);
			building_1 = new Building_1 (game, this, 300, 900);
			addChild(building_1);
			
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
			
			building_1.loop();
			walls.loop();
			
			info.abc.text = new String("units = " + unitList.length + ", bullets = " + bulletList.length);
		}

	}
}