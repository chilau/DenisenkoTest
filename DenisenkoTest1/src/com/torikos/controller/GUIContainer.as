package com.torikos.controller
{
	import com.torikos.controller.events.DraggableGUIComponentEvent;
	import com.torikos.controller.events.GUIComponentEvent;
	import com.torikos.view.BaseGUIView;
	import com.torikos.view.events.BaseGUIViewEvent;
	
	import flash.events.IEventDispatcher;
	
	/**
	 * Контроллер контейнера графических элементов
	 */
	public class GUIContainer extends DraggableGUIComponent
	{
		/**
		 * Все отображаемые графические элементы
		 */
		protected var _childs:ZController;
		
		/**
		 * Конструктор
		 */
		public function GUIContainer(target:IEventDispatcher=null)
		{
			super(target);
			
			_childs = new ZController();
		}
		
		/**
		 * Добавить элемент
		 */
		public function addChild(child:GUIComponent):void
		{
			child.init(_canvas);
			child.addEventListener(GUIComponentEvent.NEED_REDRAW, onChildNeedRedraw);
			child.addEventListener(GUIComponentEvent.NEED_SAVE_SETTINGS, onChildNeedSaveSettings);
			child.addEventListener(DraggableGUIComponentEvent.RELEASED, onChildReleased);
			child.addEventListener(DraggableGUIComponentEvent.CLICK, onChildClick);
			child.addEventListener(DraggableGUIComponentEvent.MOVED, onChildMove);
			
			_childs.addChild(child);
			
			returnChild(child);
			
			var viewClickEvent:DraggableGUIComponentEvent = new DraggableGUIComponentEvent(DraggableGUIComponentEvent.CLICK);
			dispatchEvent(viewClickEvent);
		}
		
		/**
		 * Обработчик события высвобождения объекта после перетаскивания
		 */
		protected function onChildReleased(event:DraggableGUIComponentEvent):void
		{
			var child:GUIComponent = event.target as GUIComponent;
			if (child == null)
			{
				return;
			}
			
			if (model == null)
			{
				return;
			}
			
			returnChild(child);
		}
		
		/**
		 * Вернуть объект внутрь контейнера
		 */
		protected function returnChild(child:GUIComponent):void
		{
			if (model == null)
			{
				return;
			}
			
			var newX:int = child.model.x;
			var newY:int = child.model.y;
			
			if (child.model.x < 0)
			{
				newX = 0;
			}
			
			if (child.model.x + child.model.width > model.width)
			{
				newX = model.width - child.model.width;
			}
			
			if (child.model.y < 0 + 20)
			{
				newY = 20;
			}
			
			if (child.model.y + child.model.height > model.height)
			{
				newY = model.height - child.model.height;
			}
			
			if (newX != child.model.x || newY != child.model.y)
			{
				child.moveTo(newX, newY);
			}
		}
		
		/**
		 * Обработчик события нажатия на объект, находящийся на форме
		 */
		private function onChildClick(event:DraggableGUIComponentEvent):void
		{
			var viewClickEvent:DraggableGUIComponentEvent = new DraggableGUIComponentEvent(DraggableGUIComponentEvent.CLICK);
			dispatchEvent(viewClickEvent);
		}
		
		/**
		 * Обработчик события перетаскивания контейром предком
		 */
		private function onChildMove(event:DraggableGUIComponentEvent):void
		{
			if (event.canMoveParent && event.shiftPressed)
			{
				return;
			}
			
			if (_model == null)
			{
				return;
			}
			
			_model.x += event.xPos;
			_model.y += event.yPos;
			
			_canvas.x = _model.x;
			_canvas.y = _model.y;
		}
		
		/**
		 * Обработчик события достижения устойчивого состояния одним из содержищихся на контейнере компонетом
		 */
		private function onChildNeedSaveSettings(event:GUIComponentEvent):void
		{
			var saveEvent:GUIComponentEvent = new GUIComponentEvent(GUIComponentEvent.NEED_SAVE_SETTINGS);
			dispatchEvent(saveEvent);
		}
		
		/**
		 * Обработчик события запроса перерисовки со стороны одного из содержащихся в контейнере компонента
		 */
		private function onChildNeedRedraw(event:GUIComponentEvent):void
		{
			reDraw();
			
			var needRedrawEvent:GUIComponentEvent = new GUIComponentEvent(GUIComponentEvent.NEED_REDRAW);
			dispatchEvent(needRedrawEvent);
		}
		
		/**
		 * Обработчик события изменения параметро моделей, влекущие за собой перерисовку представлений
		 */
		protected function onNeedReDraw(event:BaseGUIViewEvent):void
		{
			reDraw();
		}
		
		/**
		 * Перерисовка
		 */
		public override function reDraw():void
		{
			super.reDraw();
			
			for (var i:int = 0; i < _childs.length(); i++)
			{
				var guiContainer:GUIComponent = _childs.getItemByIndex(i) as GUIComponent;
				if (guiContainer == null)
				{
					continue;
				}
				
				var view:BaseGUIView = guiContainer.view;
				_canvas.addChild(view);
				
				guiContainer.reDraw();
			}
		}
		
		/**
		 * Все отображаемые графические элементы
		 */
		public function get childs():Vector.<GUIComponent>
		{
			return _childs.childs;
		}
	}
}