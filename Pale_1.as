package  {
	import flash.display.MovieClip;
	import flash.events.Event;

	import flash.display.Stage;
	import flash.events.MouseEvent;

	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import flash.geom.Transform; 
	import flash.geom.ColorTransform;

	public class Pale_1 extends MovieClip {
		public var game: Game;
		
		public var death: Boolean = false;
		
		public var energyMax: int = 190;
		public var energy: int = 0;
		public var healthMax: int = 20;
		public var health: int = healthMax;
		
		public var speed: Number = 2;
		
		public var speedX: Number = 0;
		public var speedY: Number = 0;
		
		public var act1_delay: int = 0;
		public var act1_damage: int = 30;
		public var act1_radius: int = 70;
		
		public var i: int;
		public var j: int;
		public var number: Number;
		public var number1: Number;
		public var number2: Number;
		public var number3: Number;
		public var token:Boolean = false;
		public var point: Point;
		private var sqrt2: Number = Math.sqrt(2);
		
		public var playerPoint: Point = new Point(400, 550);
		
		public var usualColour: ColorTransform = new ColorTransform ();
		public var hitTimer: int = 0;
		public var redOnHit: ColorTransform = new ColorTransform (2.5);
		
		public var activity: Boolean = false;
		
		public var loop2_delay: int = 0;
		public var goal: Point;
		
		public var mission: String;
		public var target: Array = [0];
		
		public var r: int = 8;

		public function Pale_1(main:Game, X: int, Y: int, theMission: String = "idle"): void {
			this.x = X;
			this.y = Y;
			game = main;
			goal = new Point (X, Y);
			mission = theMission;
			//loop2_delay = game.level.common.loop_order++;
		}
		
		public function loop(): void {
			if (hitTimer == 1) {
				--hitTimer;
				this.transform.colorTransform = usualColour;
			} else if (hitTimer) {
				--hitTimer
				this.transform.colorTransform = redOnHit;
			}
			
			if (health <= 0)
				death = true;
			
			if (energy < energyMax)
				++energy;
			
			if (act1_delay > 0)
				--act1_delay;
			
			if (loop2_delay) {
				--loop2_delay;
			} else {
				loop2();
				loop2_delay = 20;
			}
			if (mission == "move to target") {
				if ((Math.sqrt((goal.x - x)*(goal.x - x) + (goal.y - y)*(goal.y - y))) && (((goal.x - x) > 0) == (speedX > 0)) && (((goal.y - y) > 0) == (speedY > 0))) {
					x += speedX;
					y += speedY;
				} else {
					if (Math.sqrt((target[0].x - x)*(target[0].x - x) + (target[0].y - y)*(target[0].y - y)) <= act1_radius) {
						if (act1_delay == 0) {
							target[0].onHit(act1_damage);
							act1_delay = 40;
						}
					} else {
						if (!loop2()) {
							mission = "idle";
							gotoAndStop(3);
						}
					}
				}
			}
			
		}
		
		public function loop2(): Boolean {
			var target_is_detected: Boolean = false;
			for (i = 0; i < game.playerList.length; ++i) {
				token = true;
				point = new Point (game.playerList[i].x, game.playerList[i].y);
				var vectorToGoal: Point = new Point (point.x - x, point.y - y);
				var distance: Number = Math.sqrt((point.x - x)*(point.x - x) + (point.y - y)*(point.y - y));
				if (distance < 300) {
					var stepX: Number = speed*vectorToGoal.x/distance;
					var stepY: Number = speed*vectorToGoal.y/distance;
					var testPoint: Point = new Point (x, y);
					var testPointGlobal: Point;
					for (j = speed; j < distance; j += speed) {
						testPoint.x += stepX;
						testPoint.y += stepY;
						testPointGlobal = game.level.localToGlobal(testPoint);
						if (game.level.walls.hitTestPoint(testPointGlobal.x, testPointGlobal.y, true)) {
							token = false;
							break;
						}
					}
					if (token) {
						target_is_detected = true;
						goal = new Point (game.playerList[i].x, game.playerList[i].y);
						speedX = stepX;
						speedY = stepY;
						mission = "move to target";
						rotation = Math.atan2(speedY, speedX)*180/Math.PI + 90;
						target[0] = game.playerList[i];
						gotoAndStop(2);
					}
				}
			}
			return target_is_detected;
		}
			
		
		public function onHit(damage: int): void {
			health -= damage;
			hitTimer = 5;
		}
		
		public function destroy(): void {
			var explosion_basic:Explosion_basic = new Explosion_basic(x, y, 5);
			game.level.layerList[3].addChild(explosion_basic);
			game.level.common.removeChild(this);
		}
	}
}