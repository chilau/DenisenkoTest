package com.torikos.view
{
	import com.torikos.model.BaseGUIModel;
	
	/**
	 * Класс, описывающий представление графического окна
	 */
	public class WindowView extends BaseGUIView
	{
		/**
		 * Высота шапки формы
		 */
		private const _topHeight:int = 20;
		
		/**
		 * Конструктор
		 */
		public function WindowView(model:BaseGUIModel)
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
			
			var top:AdvancedSprite = createSquare(0, 0, _model.width, _model.height, _model.isActive ? 0xCDC9C9 : 0xEEE9E9);
			var form:AdvancedSprite = createSquare(0, _topHeight, _model.width, _model.height - _topHeight, _model.isActive ? 0xEEE9E9 : 0xFAF8F8);
			var closeButton:AdvancedSprite = createCircle(15, 10, 5, _model.isActive ? 0xFF4500 : 0xEEE9E9);
			var minimizeButton:AdvancedSprite = createCircle(35, 10, 5, _model.isActive ? 0xFFD700 : 0xEEE9E9);
			var maximizeButton:AdvancedSprite = createCircle(55, 10, 5, _model.isActive ? 0x90EE90 : 0xEEE9E9);
			
			addChild(top);
			addChild(closeButton);
			addChild(minimizeButton);
			addChild(maximizeButton);
			addChild(form);
		}
		
		/**
		 * Создать прямоугольник
		 */
		private function createSquare(x:int, y:int, width:int, height:int, color:uint):AdvancedSprite
		{
			var square:AdvancedSprite = new AdvancedSprite();
			square.graphics.lineStyle(1, _model.isActive ? 0x000000 : 0xC0C0C0);
			square.graphics.beginFill(color);
			square.graphics.drawRoundRect(0, 0, width, height, 10);
			square.graphics.endFill();
			square.x = x;
			square.y = y;
			
			return square;
		}
		
		/**
		 * Создать окружность
		 */
		private function createCircle(x:int, y:int, radius:int, color:uint):AdvancedSprite
		{
			var circle:AdvancedSprite = new AdvancedSprite();
			circle.graphics.lineStyle(1, 0x000000);
			circle.graphics.beginFill(color);
			circle.graphics.drawCircle(0, 0, radius);
			circle.graphics.endFill();
			circle.x = x;
			circle.y = y;
			
			return circle;
		}
	}
}