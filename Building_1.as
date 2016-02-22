package  {
	
	import flash.display.MovieClip;
	import flash.geom.Transform;
	import flash.geom.Matrix;

	public class Building_1 extends MovieClip {
		
		public var game: Game;
		public var death: Boolean = false;
		public var ground: MyRectangle;
		var basicMa:Matrix;
		var basicMb:Matrix;
		var basicMc:Matrix;
		var basicMd:Matrix;
		var a:Wall_1;
		var b:Wall_1;
		var c:Wall_1;
		var d:Wall_1;
		var ma:Mask_1;
		var mb:Mask_1;
		var mc:Mask_1;
		var md:Mask_1;
		var top:Top_1;

		var curM:Matrix;
		public var up:int = 50;
		public var down:int = 100;
		var dx:int;
		var dy:int;
		var gSize:int;
		var floors:Number;
		//public var walls: Walls;
		public var player: int;
		
		public function Building_1 (main: Game, X: int, Y: int, groundSize: int = 200, fls: Number = 100): void {
			this.x = X;
			this.y = Y;
			game = main;
			gSize = groundSize;
			floors = fls;
			ground = new MyRectangle (x, y, gSize+30, gSize+30);
			
			a = new Wall_1();
			a.y = gSize/2;
			basicMa = a.transform.matrix;
			addChild(a);
			ma = new Mask_1();
			ma.y = gSize/2;
			addChild(ma);
			a.mask = ma;
			
			b = new Wall_1();
			b.x = gSize/2;
			b.rotation = -90;
			basicMb = b.transform.matrix;
			addChild(b);
			mb = new Mask_1();
			mb.x = gSize/2;
			mb.rotation = -90;
			addChild(mb);
			b.mask = mb;
			
			c = new Wall_1();
			c.x = -gSize/2;
			c.rotation = 90;
			basicMc = c.transform.matrix;
			addChild(c);
			mc = new Mask_1();
			mc.x = -gSize/2;
			mc.rotation = 90;
			addChild(mc);
			c.mask = mc;
			
			d = new Wall_1();
			d.y = -gSize/2;
			d.rotation = 180;
			basicMd = d.transform.matrix;
			addChild(d);
			md = new Mask_1();
			md.y = -gSize/2;
			md.rotation = 180;
			addChild(md);
			d.mask = md;
			
			top = new Top_1();
			top.height = gSize + floors;
			top.width = gSize + floors;
			addChild(top);
		}
		public function loop(): void {
			player = game.activePlayer;
			if (player != -1) {
				curM = basicMa;
				dx = game.playerList[player].x - a.x - x;
				dy = game.playerList[player].y - a.y - y;
				curM.d = dy/up;
				curM.c = dx/up;
				a.transform.matrix = curM;
				//addChild(a);
				//a.mask = ma;
				
				ma.scaleY = dy/100;
				
				top.x = a.x - dx*up/down;
				top.y = a.y - dy*up/down;
				
				curM = basicMb;
				dx = game.playerList[player].x - b.x - x;
				dy = game.playerList[player].y - b.y - y;
				curM.c = dx/up;
				curM.d = dy/up;
				b.transform.matrix = curM;
				
				mb.scaleY = dx/down;
				
				curM = basicMc;
				dx = game.playerList[player].x - c.x - x;
				dy = game.playerList[player].y - c.y - y;
				curM.c = dx/up;
				curM.d = dy/up;
				c.transform.matrix = curM;
				
				mc.scaleY = -dx/down;
				
				curM = basicMd;
				dx = game.playerList[player].x - d.x - x;
				dy = game.playerList[player].y - d.y - y;
				curM.d = (dy)/up;
				curM.c = dx/up;
				d.transform.matrix = curM;
				
				md.scaleY = -dy/down;
				
				if (game.playerList[player].y > a.y + y) {
					if (game.playerList[player].x > b.x + x) {
						addChild(a);
						a.mask = ma;
						addChild(b);
						b.mask = mb;
					} else if (game.playerList[player].x > c.x + x) {
						addChild(a);
						a.mask = ma;
					} else {
						addChild(a);
						a.mask = ma;
						addChild(c);
						c.mask = mc;
					}
				} else if (game.playerList[player].y > d.y + y) {
					if (game.playerList[player].x > b.x + x) {
						addChild(b);
						b.mask = mb;
					} else if (game.playerList[player].x < c.x + x) {
						addChild(c);
						c.mask = mc;
					}
				} else {
					if (game.playerList[player].x > b.x + x) {
						addChild(d);
						d.mask = md;
						addChild(b);
						b.mask = mb;
					} else if (game.playerList[player].x > c.x + x) {
						addChild(d);
						d.mask = md;
					} else {
						addChild(d);
						d.mask = md;
						addChild(c);
						c.mask = mc;
					}
				}
				addChild(top);
			}
		}
	}
}
