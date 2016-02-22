package {
	import flash.display.MovieClip;
	import flash.events.Event;

	import flash.display.Stage;
	import flash.events.MouseEvent;

	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import flash.geom.Transform; 
	import flash.geom.ColorTransform;

	public class Player1 extends MovieClip {
		public var game: Game;
		public var facet: Facet1;
		
		public var death: Boolean = false;
		
		public var energyMax: int = 190;
		public var healthMax: int = 100;
		public var jumpCost: int = 100;
		public var speed: Number = 5;
		public var playerPoint: Point = new Point(400, 550);
		
		public var energy: int = 0;
		public var health: int = healthMax;
		public var shotDelay: int = 0;
		
		public var i: int;
		public var j: int;
		public var number: Number;
		public var number1: Number;
		public var number2: Number;
		public var number3: Number;
		public var token:Boolean = false;
		public var point: Point;
		
		private var sqrt2: Number = Math.sqrt(2);
		public var roll: int = 0;
		public var jumpAccelerator: int = 3;
		
		public var rotSpeed: Number;
		public var coursor: Coursor1;
		
		public var usualColour: ColorTransform = new ColorTransform ();
		public var hitTimer: int = 0;
		public var redOnHit: ColorTransform = new ColorTransform (2.5);
		
		public var activity: Boolean = false;
		
		public var r: int = 8;

		public function Player1(main:Game, X: int = 400, Y: int = 550): void {
			this.x = X;
			this.y = Y;
			game = main;
			coursor = new Coursor1 (400, 510, this);
			facet = new Facet1 (0, 0);
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
			
			if (shotDelay > 0)
				--shotDelay;
			
			if (activity) {
			
				token = false;
				number = speed / sqrt2;
				point = game.level.localToGlobal(new Point(x, y));

				if (game.qPressed) {
					if ((roll == 0) && (energy >= 0)) {
						roll = -10;
						energy -= jumpCost;
					}
				} else if (game.ePressed) {
					if ((roll == 0) && (energy >= 0)) {
						roll = 10;
						energy -= jumpCost;
					}
				}

				if (roll > 0) {
					token = true;
					--roll;
					number1 = 0;
					//number2 = 0;
					//number3 = 0;
					for (i = 1; i <= jumpAccelerator; ++i) {
						if (!game.level.walls.hitTestPoint(point.x + 13+ speed*(i-1), point.y, true)) {
							number1 -= speed;
							//number2 += Math.cos(rotation * (Math.PI / 180))*speed;
							//number3 += Math.sin(rotation * (Math.PI / 180))*speed;
						} else {
							break;
						}
					}
					game.level.x += number1;
					//x += number2;
					//y += number3;
				} else if (roll < 0) {
					token = true;
					++roll;
					number1 = 0;
					//number2 = 0;
					//number3 = 0;
					for (i = 1; i <= jumpAccelerator; ++i) {
						if (!game.level.walls.hitTestPoint(point.x - 13+ speed*(i-1), point.y, true)) {
							number1 += speed;
							//number2 -= Math.cos(rotation * (Math.PI / 180))*speed;
							//number3 -= Math.sin(rotation * (Math.PI / 180))*speed;
						} else {
							break;
						}
					}
					game.level.x += number1;
					//x += number2;
					//y += number3;
					
				} else {

					if (game.leftPressed) {
						if (game.upPressed && !game.level.walls.hitTestPoint(point.x - 13 / sqrt2, point.y - 13 / sqrt2, true)) {
							game.level.x += number;
							game.level.y += number;
							token = true;
						} else if (game.downPressed && !game.level.walls.hitTestPoint(point.x - speed / sqrt2, point.y + speed / sqrt2, true)) {
							game.level.x += number;
							game.level.y -= number/2;
							token = true;
						} else if (!game.level.walls.hitTestPoint(point.x - 13, point.y, true)) {
							game.level.x += speed;
							token = true;
						}
					} else if (game.rightPressed) {
						if (game.downPressed && !game.level.walls.hitTestPoint(point.x + 13 / sqrt2, point.y + 13 / sqrt2, true)) {
							game.level.x -= number;
							game.level.y -= number/2;
							token = true;
						} else if (game.upPressed && !game.level.walls.hitTestPoint(point.x + 13 / sqrt2, point.y - 13 / sqrt2, true)) {
							game.level.x -= number;
							game.level.y += number;
							token = true;
						} else if (!game.level.walls.hitTestPoint(point.x + 13, point.y, true)) {
							game.level.x -= speed;
							token = true;
						}
					} else if (game.upPressed && !game.level.walls.hitTestPoint(point.x, point.y - 13, true)) {
						game.level.y += speed;
						token = true;
					} else if (game.downPressed && !game.level.walls.hitTestPoint(point.x, point.y + 13, true)) {
						game.level.y -= speed/2;
						token = true;
					}
				}
				
				if (token == true) {
					point = game.level.globalToLocal(playerPoint); //конвертация локальных координат в глобальные
					x = point.x;
					y = point.y; //помещение игрока в то место в локальной системе координат, которое соответствует месту игрока в глобальных координатах (playerPoint) 
				}
			
				
				if (game.leftMousePressed) {
					shootingBullet();
				}
			
			}

		}
		
		public function rotateAndCoursor(e: MouseEvent): void {

			point = new Point(x, y);
			rotSpeed = -e.movementX / 2;
			if (rotSpeed > 20)
				rotSpeed = 20;
			else if (rotSpeed < -20)
				rotSpeed = -20;
			if (roll != 0)
				rotSpeed / 2;
			var t: Matrix = game.level.transform.matrix;
			point = t.transformPoint(point);
			t.translate(-point.x, -point.y);
			t.rotate(rotSpeed * (Math.PI / 180));
			t.translate(point.x, point.y);
			game.level.transform.matrix = t;
			rotation -= rotSpeed;

			coursor.moving(e.movementY);

		}
		
		public function shootingBullet(): void {
			if ((energy >= 0) && (shotDelay == 0)) {
				point = game.level.globalToLocal(new Point(coursor.x, coursor.y));
				var bullet: Bullet = new Bullet(game, x, y, point.x + (Math.random() * 20 - 10), point.y + (Math.random() * 20 - 10));
				game.level.common.bulletList.push(bullet); //add this bullet to the bulletList array
				game.level.common.addChild(bullet);
				shotDelay = 8;
			}
		}
		
		public function onHit(damage: int): void {
			health -= damage;
			hitTimer = 5;
		}
		
		public function destroy(): void {
			var explosion_basic:Explosion_basic = new Explosion_basic(x, y, 5);
			game.level.common.addChild(explosion_basic);
			game.level.common.removeChild(this);
		}
		
		public function toggleActivityUp(): void {
			
			point = game.level.localToGlobal(new Point(x, y));
			game.level.x += playerPoint.x - point.x;
			game.level.y += playerPoint.y - point.y;
			
			point = new Point(x, y);
			
			var t: Matrix = game.level.transform.matrix;
			point = t.transformPoint(point);
			t.translate(-point.x, -point.y);
			t.rotate(-rotation * (Math.PI / 180));
			t.translate(point.x, point.y);
			game.level.transform.matrix = t;

			game.addChild(facet);
			game.addChild(coursor);
			game.parent.addEventListener(MouseEvent.MOUSE_MOVE, game.level.player1.rotateAndCoursor);
			activity = true;
		}
		
		public function toggleActivityDown(): void {
			game.removeChild(facet);
			game.removeChild(coursor);
			game.parent.removeEventListener(MouseEvent.MOUSE_MOVE, game.level.player1.rotateAndCoursor);
			activity = false;
		}
		
	}
}