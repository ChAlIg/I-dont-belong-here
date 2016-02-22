package {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import flash.geom.Matrix;
	import flash.geom.Point;

	public class Level extends MovieClip {
		public var game: Game;
		
		public var player1: Player1;
		public var player2: Player2;

		public var point: Point;
		private var i: int;
		private var j: int;
		
		public var layerList: Vector.<Container> = new Vector.<Container>();
		public var common: Container;
		public var walls: Container;
		
		public var info: Info;

		public function Level(main:Game, content:String): void {
			game = main;
			
			//creating of the level "layer structure"
			//0 - ground (background & what lays on the ground)
			//1 - walls (impassable zones)
			//2 - common (general units&bullets)
			//3 - atmosphere (fog etc)
			//4 - above (sufficiently high walls&objects; roofs)
			//5 - sky
			//6 - interface
			var t: Container;
			t = new Container();
			addChild(t);
			layerList.push(t);
			walls = new Container();
			addChild(walls);
			layerList.push(walls);
			common = new Container();
			addChild(common);
			layerList.push(common);
			for (i = 3; i < 7; ++i) {
				t = new Container();
				addChild(t);
				layerList.push(t);
			}
			
			var pale_1: Pale_1;
			var trash: Trash;
			var building_1: Building_1;
			var ambient_1: Ambient_1 = new Ambient_1();
			layerList[0].addChild(ambient_1);
			
			var mainWall: Walls = new Walls(0, 0);
			layerList[1].addChild(mainWall);
			
			var fog: Fog = new Fog(game);
			layerList[3].addChild(fog);
			layerList[3].unitList.push(fog);
			
			trash = new Trash(game, 320, 240);
			common.addChild(trash);
			common.unitList.push(trash);
			trash = new Trash(game, 234, 556);
			common.addChild(trash);
			common.unitList.push(trash);
			trash = new Trash(game, 34, 766);
			common.addChild(trash);
			common.unitList.push(trash);
			trash = new Trash(game, 457, 23);
			common.addChild(trash);
			common.unitList.push(trash);
			trash = new Trash(game, 345, 423);
			common.addChild(trash);
			common.unitList.push(trash);
			trash = new Trash(game, 264, 567);
			common.addChild(trash);
			common.unitList.push(trash);
			trash = new Trash(game, 32, 43);
			common.addChild(trash);
			common.unitList.push(trash);
			trash = new Trash(game, 123, 123);
			common.addChild(trash);
			common.unitList.push(trash);
			trash = new Trash(game, 400, 550);
			common.addChild(trash);
			common.unitList.push(trash);
			for (i = 0; i <=800; i += 200) {
				for (j = 0; j <= 600; j += 200) {
					trash = new Trash(game, i, j);
					common.addChild(trash);
					common.unitList.push(trash);
				}
			}
			player1 = new Player1(game);
			common.addChild(player1);
			common.unitList.push(player1);
			player2 = new Player2(game);
			common.addChild(player2);
			common.unitList.push(player2);
			game.playerList.push(player1, player2);
			info = new Info(0, 0);
			addChild(info);
			pale_1 = new Pale_1 (game, 900, 300);
			common.addChild(pale_1);
			common.unitList.push(pale_1);
			building_1 = new Building_1 (game, 300, 900);
			layerList[4].addChild(building_1);
			layerList[4].unitList.push(building_1)
			walls.addChild(building_1.ground);
			building_1 = new Building_1 (game, 850, 900);
			layerList[4].addChild(building_1);
			layerList[4].unitList.push(building_1)
			walls.addChild(building_1.ground);
			building_1 = new Building_1 (game, 1400, 900);
			layerList[4].addChild(building_1);
			layerList[4].unitList.push(building_1)
			walls.addChild(building_1.ground);
			building_1 = new Building_1 (game, 300, 1450);
			layerList[4].addChild(building_1);
			layerList[4].unitList.push(building_1)
			walls.addChild(building_1.ground);
			building_1 = new Building_1 (game, 850, 1450);
			layerList[4].addChild(building_1);
			layerList[4].unitList.push(building_1)
			walls.addChild(building_1.ground);
			building_1 = new Building_1 (game, 1400, 1450);
			layerList[4].addChild(building_1);
			layerList[4].unitList.push(building_1)
			walls.addChild(building_1.ground);
		}
		public function loop(): void {
			/*if (loop_order) {
				--loop_order;
			} else {
				loop_order = 20;
			}*/
			for (i = 0; i < 7; ++i) {
				layerList[i].loop();
			}
			/*for (i = unitList.length - 1; i >= 0; --i) //for each one
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
			walls.loop();*/
			
			info.abc.text = new String("units in common layer = " + common.unitList.length + ", bullets in there = " + common.bulletList.length);
		}

	}
}