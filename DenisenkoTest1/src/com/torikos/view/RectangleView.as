package com.torikos.view
{
	import com.torikos.model.BaseGUIModel;
	
	/**
	 * Класс, описывающий представление прямоугольника
	 */
	public class RectangleView extends BaseGUIView
	{
		/**
		 * Конструктор
		 */
		public function RectangleView(model:BaseGUIModel)
		{
			super(model);
		}
		
		/**
		 * Отрисовать элемент
		 */
		public override function draw():void
		{
			super.draw();
			
			if (_model == null)
			{
				return;
			}
			
			var square:AdvancedSprite = createSquare(_model.width, _model.height, _model.color);
			addChild(square);
		}
		
		/**
		 * Создать прямоугольник
		 */
		private function createSquare(width:int, height:int, color:uint):AdvancedSprite
		{
			var square:AdvancedSprite = new AdvancedSprite();
			square.graphics.lineStyle(1, 0x000000);
			square.graphics.beginFill(color);
			square.graphics.drawRect(0, 0, width, height);
			square.graphics.endFill();
			
			return square;
		}
	}
}