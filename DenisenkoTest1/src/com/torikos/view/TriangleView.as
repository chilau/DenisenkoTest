package com.torikos.view
{
	import com.torikos.model.BaseGUIModel;
	
	/**
	 * Класс, описывающий представление треушольника
	 */
	public class TriangleView extends BaseGUIView
	{
		/**
		 * Конструктор
		 */
		public function TriangleView(model:BaseGUIModel)
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
			
			var triangle:AdvancedSprite = createTriangle(_model.width, _model.height, _model.color);
			
			addChild(triangle);
		}
		
		/**
		 * Создать треугольник
		 */
		private function createTriangle(width:int, height:int, color:uint):AdvancedSprite
		{
			var triangle:AdvancedSprite = new AdvancedSprite();
			triangle.graphics.lineStyle(1, 0x000000);
			triangle.graphics.beginFill(color);
			triangle.graphics.moveTo(height/2, 0);
			triangle.graphics.lineTo(height, height);
			triangle.graphics.lineTo(0, height);
			triangle.graphics.lineTo(height/2, 0);
			
			return triangle;
		}
	}
}