package ConnectModule.websocket 
{
	/**
	 * ...
	 * @author hhg4092
	 */
	public final class Message
	{			
		public static const DEMO_SESSION:String = "FO1h0Is1RPGswo/tVScLzKvWRvE5dEvkjgIWuHTn6BY=";
		
		//login
		public static const MSG_TYPE_LOGIN:int = 100
		public static const MSG_TYPE_LOGIN_ERROR:int = 101
		
		
		//lobby
		//進入大廳
		public static const MSG_TYPE_LOBBY:int = 200
		
		//選擇遊戲
		public static const MSG_TYPE_SELECT_GAME:int = 300
		
		//某個遊戲大廳
		public static const MSG_TYPE_GAME_LOBBY:int = 400
		
		//進入指定遊戲
		public static const MSG_TYPE_INTO_GAME:int = 500
		
		//Game
		public static const MSG_TYPE_GAME_OPEN_INFO:int = 501		
		public static const MSG_TYPE_BET:int = 502
		public static const MSG_TYPE_BET_INFO:int = 503
		public static const MSG_TYPE_ROUND_INFO:int = 504
		public static const MSG_TYPE_STATE_INFO:int = 505
	}

}