package com.torikos.view
{
	import com.torikos.model.BaseGUIModel;
	import com.torikos.model.CircleModel;
	
	/**
	 * Класс, описывающий представление окружности
	 */
	public class CircleView extends BaseGUIView
	{
		/**
		 * Конструктор
		 */
		public function CircleView(model:BaseGUIModel)
		{
			super(model);
		}
		
		/**
		 * Отрисовать элемент
		 */
		public override function draw():void
		{
			super.draw();
			
			var circleModel:CircleModel = _model as CircleModel;
			if (circleModel == null)
			{
				return;
			}
			
			var circle:AdvancedSprite = createCircle(circleModel.radius, circleModel.color);
			circle.x = circleModel.radius;
			circle.y = circleModel.radius;
			
			addChild(circle);
		}
		
		/**
		 * Создать прямоугольник
		 */
		private function createCircle(radius:int, color:uint):AdvancedSprite
		{
			var square:AdvancedSprite = new AdvancedSprite();
			square.graphics.lineStyle(1, 0x000000);
			square.graphics.beginFill(color);
			square.graphics.drawCircle(0, 0, radius);
			square.graphics.endFill();
			
			return square;
		}
	}
}