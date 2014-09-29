package com.torikos.view
{
	import com.torikos.model.BaseGUIModel;
	
	import flash.display.Sprite;

	/**
	 * Графическое представление
	 */
	public class BaseGUIView extends AdvancedSprite
	{
		/**
		 * Модель
		 */
		protected var _model:BaseGUIModel;
		
		/**
		 * Конструктор
		 */
		public function BaseGUIView(model:BaseGUIModel)
		{
			super();
			
			_model = model;
		}
		
		/**
		 * Модель
		 */
		public function set model(value:BaseGUIModel):void
		{
			_model = value;
		}
		
		/**
		 * Модель
		 */
		public function get model():BaseGUIModel
		{
			return _model;
		}
		
		/**
		 * Отрисовать элемент
		 */
		public function draw():void
		{
			clear();
		}
		
		/**
		 * Очистить канву
		 */
		private function clear():void
		{
			for (var i:int = numChildren - 1; i >= 0; i--)
			{
				var sprite:Sprite = this.getChildAt(i) as Sprite;
				if (sprite == null)
				{
					continue;
				}
				
				removeChild(sprite);
			}
		}
	}
}