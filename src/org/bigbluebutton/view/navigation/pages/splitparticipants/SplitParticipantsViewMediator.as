package org.bigbluebutton.view.navigation.pages.splitparticipants {
	
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	import mx.core.FlexGlobals;
	import mx.events.ItemClickEvent;
	import mx.resources.ResourceManager;
	import org.bigbluebutton.command.ClearUserStatusSignal;
	import org.bigbluebutton.command.MoodSignal;
	import org.bigbluebutton.core.IUsersService;
	import org.bigbluebutton.model.IConferenceParameters;
	import org.bigbluebutton.model.IUserSession;
	import org.bigbluebutton.model.IUserUISession;
	import org.bigbluebutton.model.User;
	import org.bigbluebutton.model.UserList;
	import org.bigbluebutton.view.navigation.pages.PagesENUM;
	import org.bigbluebutton.view.navigation.pages.splitsettings.SplitViewEvent;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import spark.events.IndexChangeEvent;
	
	public class SplitParticipantsViewMediator extends Mediator {
		
		[Inject]
		public var view:ISplitParticipantsView;
		
		[Inject]
		public var userUISession:IUserUISession;
		
		override public function initialize():void {
			FlexGlobals.topLevelApplication.pageName.text = ResourceManager.getInstance().getString('resources', 'participants.title');
			eventDispatcher.addEventListener(SplitViewEvent.CHANGE_VIEW, changeView);
			view.participantsList.pushView(PagesENUM.getClassfromName(PagesENUM.PARTICIPANTS));
		}
		
		private function changeView(event:SplitViewEvent) {
			view.participantDetails.pushView(event.view);
			userUISession.pushPage(PagesENUM.SPLITPARTICIPANTS, event.details)
		}
		
		override public function destroy():void {
			super.destroy();
			eventDispatcher.removeEventListener(SplitViewEvent.CHANGE_VIEW, changeView);
			view.dispose();
			view = null;
		}
	}
}
