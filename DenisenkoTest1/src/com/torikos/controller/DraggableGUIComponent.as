package com.torikos.controller
{
	import com.torikos.controller.events.DraggableGUIComponentEvent;
	import com.torikos.controller.events.GUIComponentEvent;
	import com.torikos.view.AdvancedSprite;
	import com.torikos.view.BaseGUIView;
	import com.torikos.view.CircleView;
	
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	/**
	 * Контроллер, описывающий поведение перетаскиваемого объекта
	 */
	public class DraggableGUIComponent extends GUIComponent
	{
		/**
		 * Смещение по оси X
		 */
		protected var _shiftX:int;
		/**
		 * Смещение по оси Y
		 */
		protected var _shiftY:int;
		/**
		 * Объект находился в состоянии перетаскивания
		 */
		protected var _moved:Boolean;
		
		/**
		 * Конструктор
		 */
		public function DraggableGUIComponent(target:IEventDispatcher=null)
		{
			super(target);
			
			_moved = false;
		}
		
		/**
		 * Представление
		 */
		public override function set view(value:BaseGUIView):void
		{
			super.view = value;
			
			_view.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, true, 0, true);
		}
		
		
		/**
		 * Обработчик события нажатия кнопки мыши
		 */
		protected function onMouseDown(event:MouseEvent):void
		{
			_view.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_view.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			var sprite:AdvancedSprite = event.target as AdvancedSprite;
			
			_shiftX = event.stageX - _model.x;
			_shiftY = event.stageY - _model.y;
			
			var clickEvent:DraggableGUIComponentEvent = new DraggableGUIComponentEvent(DraggableGUIComponentEvent.CLICK);
			dispatchEvent(clickEvent);
		}
		
		/**
		 * Обработчик события перемещиня мыши
		 */
		protected function onMouseMove(event:MouseEvent):void
		{
			if (!_moved)
			{
				_moved = true;
			}
			
			var movedEvent:DraggableGUIComponentEvent = new DraggableGUIComponentEvent(DraggableGUIComponentEvent.MOVED);
			movedEvent.xPos = event.stageX - _shiftX;
			movedEvent.yPos = event.stageY - _shiftY;
			dispatchEvent(movedEvent);
			
			_model.x = movedEvent.xPos;
			_model.y = movedEvent.yPos;
			
			_canvas.x = _model.x;
			_canvas.y = _model.y;
		}
		
		/**
		 * Обработчик события отпускания кнопки мыши
		 */
		protected function onMouseUp(event:MouseEvent):void
		{
			_view.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_view.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			if (_moved)
			{
				var releasedEvent:DraggableGUIComponentEvent = new DraggableGUIComponentEvent(DraggableGUIComponentEvent.RELEASED);
				releasedEvent.localX = _view is CircleView ? event.localX + _model.width / 2 : event.localX;
				releasedEvent.localY = _view is CircleView ? event.localY + _model.width / 2 : event.localY;
				dispatchEvent(releasedEvent);
				
				var saveEvent:GUIComponentEvent = new GUIComponentEvent(GUIComponentEvent.NEED_SAVE_SETTINGS);
				dispatchEvent(saveEvent);
				
				_moved = false;
			}
		}
	}
}