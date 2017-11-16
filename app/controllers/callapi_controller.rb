class CallapiController < ApplicationController
  
require 'http'
CTX = OpenSSL::SSL::SSLContext.new
CTX.verify_mode = OpenSSL::SSL::VERIFY_NONE
  
  
  def getacs
    #AouthsetupControllerクラスのインスタンス化
    aouthctr = AouthsetupController.new
    accessToken = aouthctr.getAccessToken
    authtoken = "Bearer " + accessToken
    #aaa
    
    #ACS情報の取得
    res = HTTP.headers("Content-Type" => "application/json", :Authorization => authtoken)
    .get("https://api.lockstate.jp/acs/doors/" + "030cd450-230a-4c0c-bfdd-f9ee2dd1c55c" + "/access_person_accesses", :ssl_context => CTX)
    item = ActiveSupport::JSON.decode( res.body )
    
    #ACSの操作→一時解除ができているか要確認！
    res = HTTP.headers("Content-Type" => "application/json", :Authorization => authtoken)
    .put("https://api.lockstate.jp/acs/doors/" + "030cd450-230a-4c0c-bfdd-f9ee2dd1c55c" + "/temporary_unlock", :ssl_context => CTX)
    #知粋館は、a05d52a7-1a83-4966-96a9-0a3aeeb402ad
    item = ActiveSupport::JSON.decode( res.body )
    debugger
    
  end
  
  
  
  #管理者
  def getuser
    #AouthsetupControllerクラスのインスタンス化
    aouthctr = AouthsetupController.new
    accessToken = aouthctr.getAccessToken
    authtoken = "Bearer " + accessToken
    
    res = HTTP.headers("Content-Type" => "application/json", :Authorization => authtoken)
    .get("https://api.lockstate.jp/user/", :ssl_context => CTX)
    item = ActiveSupport::JSON.decode( res.body )
    
    debugger
    
  end
  
  
  #スケジュール
  def getschedules
    #AouthsetupControllerクラスのインスタンス化
    aouthctr = AouthsetupController.new
    accessToken = aouthctr.getAccessToken
    authtoken = "Bearer " + accessToken
    
    #res = HTTP.headers("Content-Type" => "application/json", :Authorization => authtoken)
    #.get("https://api.lockstate.jp/schedules/" + "b42207b8-114c-40c8-bfe4-67422e8a09b0", :ssl_context => CTX)
    #item = ActiveSupport::JSON.decode( res.body )
    
    postbody = {
      "attributes": {
        "name": "電池消耗用スケジュール1a"
      }
    }
    
    #res = HTTP.headers("Content-Type" => "application/json", :Authorization => authtoken)
    #.put("https://api.lockstate.jp/schedules/" + "b42207b8-114c-40c8-bfe4-67422e8a09b0", :ssl_context => CTX, :body => postbody.to_json)
    #item = ActiveSupport::JSON.decode( res.body )
    
    res = HTTP.headers("Content-Type" => "application/json", :Authorization => authtoken)
    .delete("https://api.lockstate.jp/schedules/" + "974e1369-a0cb-4e35-8aa5-71cb563ba064", :ssl_context => CTX)
    
    postbody = {
      "type": "lock_action_schedule",
      "attributes": {
        "name": "Automatically unlock and lock",
        "mon": [
          {
            "time": "08:00",
            "action": "unlock"
          },
          {
            "time": "18:00",
            "action": "lock"
          }
        ],
        "wed": [
          {
            "time": "08:00",
            "action": "unlock"
          },
          {
            "time": "18:00",
            "action": "lock"
          }
        ],
        "fri": [
          {
            "time": "08:00",
            "action": "unlock"
          },
          {
            "time": "18:00",
            "action": "lock"
          }
        ]
      }
    }
    
    res2 = HTTP.headers("Content-Type" => "application/json", :Authorization => authtoken)
    .post("https://api.lockstate.jp/schedules/", :ssl_context => CTX, :body => postbody.to_json)
    #item2 = ActiveSupport::JSON.decode( res2.body )
    
    debugger
  end
  
  #通知先
  def getsubscriptions
    #AouthsetupControllerクラスのインスタンス化
    aouthctr = AouthsetupController.new
    accessToken = aouthctr.getAccessToken
    authtoken = "Bearer " + accessToken
    
    res = HTTP.headers("Content-Type" => "application/json", :Authorization => authtoken)
    .get("https://api.lockstate.jp/notification_subscriptions/" + "38d5320a-1166-4252-a999-4e73b175afc9", :ssl_context => CTX)
    item = ActiveSupport::JSON.decode( res.body )
    
    postbody1 = {
      "attributes": {
        "events": [
          {
            "event_type": "acs_door_opened"
          },
          {
            "event_type": "acs_door_closed"
          },
          {
            "event_type": "acs_door_held_open"
          },
          {
            "event_type": "acs_requested_to_exit"
          },
          {
            "event_type": "unlocked"
          },
          {
            "event_type": "locked"
          },
          {
            "event_type": "access_denied"
          },
          {
            "event_type": "access_person_synced"
          },
          {
            "event_type": "access_person_sync_failed"
          },
          {
            "event_type": "access_guest_late_sync"
          },
          {
            "event_type": "connectivity"
          },
          {
            "event_type": "power_level_low"
          },
          {
            "event_type": "temperature_changed"
          },
          {
            "event_type": "humidity_changed"
          },
          {
            "event_type": "relay_enabled"
          },
          {
            "event_type": "relay_disabled"
          },
          {
            "event_type": "access_person_used"
          }
        ],
        "publisher_type": "account",
        "publisher_id": "dbe0016e-0599-49a8-8491-5273ffc5f25a",
        "subscriber_type": "email_notification_subscriber",
        "subscriber_id": "943fecd3-108e-490d-9827-5a565f99ef18"
      }
    }
    
    #res1 = HTTP.headers("Content-Type" => "application/json", :Authorization => authtoken)
    #.post("https://api.lockstate.jp/notification_subscriptions/", :ssl_context => CTX, :body => postbody1.to_json)
    #item1 = ActiveSupport::JSON.decode( res.body )
    
    postbody2 = {
      "attributes": {
        "events": [
          {
            "event_type": "unlocked"
          },
          {
            "event_type": "locked"
          }
        ]
      }
    }
    res2 = HTTP.headers("Content-Type" => "application/json", :Authorization => authtoken)
    .delete("https://api.lockstate.jp/notification_subscriptions/" + "926e2a95-32e1-4de2-8b80-9c7e386bbdf2", :ssl_context => CTX)
    #item2 = ActiveSupport::JSON.decode( res.body )
    
    
    res3 = HTTP.headers("Content-Type" => "application/json", :Authorization => authtoken)
    .get("https://api.lockstate.jp/notifications/", :ssl_context => CTX)
    item3 = ActiveSupport::JSON.decode( res3.body )
    debugger
    
    
    render :getaccessuser  
  end
  
  
  
  #通知元
  def getsubscribers
    #AouthsetupControllerクラスのインスタンス化
    aouthctr = AouthsetupController.new
    accessToken = aouthctr.getAccessToken
    authtoken = "Bearer " + accessToken
    
    res = HTTP.headers("Content-Type" => "application/json", :Authorization => authtoken)
    .get("https://api.lockstate.jp/notification_subscribers/", :ssl_context => CTX)
    item = ActiveSupport::JSON.decode( res.body )
    
    postbody = {
      "attributes": {
        "active": true,
        "name": "構造　華子",
        "email": "remotelock@kke.co.jp"
      }
    }
    #res = HTTP.headers("Content-Type" => "application/json", :Authorization => authtoken)
    #.put("https://api.lockstate.jp/notification_subscribers/" + "946541cf-e554-495c-b75d-cc27d9500763", :ssl_context => CTX, :body => postbody.to_json)
    #item = ActiveSupport::JSON.decode( res.body )
    
    postbody0 = {
      "type"=>"email_notification_subscriber",
      "attributes": {
        "active": true,
        "name": "Rob Goff",
        "email": "rob@lockstate.com"
      }
    }
    
    postbody2 = {
      "type": "text_notification_subscriber",
      "attributes": {
        "active": true,
        "name": "Rob Goff",
        "phone": "303-317-3422",
        "carrier": "att"
      }
    }
    
    postbody1 = {
      "type": "webhook_notification_subscriber",
      "attributes": {
        "active": true,
        "name": "Rob's webhook",
        "url": "https://google.com",
        "content_type": "form",
        "secret": "5f7c5b9ccedea8832a46cfca516da134"
      }
    }
    
    res1 = HTTP.headers("Content-Type" => "application/json", :Authorization => authtoken)
    .post("https://api.lockstate.jp/notification_subscribers/", :ssl_context => CTX, :body => postbody1.to_json)
    item1 = ActiveSupport::JSON.decode( res.body )
    
    #削除
    #res1 = HTTP.headers("Content-Type" => "application/json", :Authorization => authtoken)
    #.delete("https://api.lockstate.jp/notification_subscribers/" + "946541cf-e554-495c-b75d-cc27d9500763", :ssl_context => CTX)
    
    debugger
    
    render :getaccessuser
  end


  #型番
  def getmodel
    #AouthsetupControllerクラスのインスタンス化
    aouthctr = AouthsetupController.new
    accessToken = aouthctr.getAccessToken
    authtoken = "Bearer " + accessToken
    
    res = HTTP.headers("Content-Type" => "application/json", :Authorization => authtoken)
    .get("https://api.lockstate.jp/models/", :ssl_context => CTX)
    item = ActiveSupport::JSON.decode( res.body )
    
    res1 = HTTP.headers("Content-Type" => "application/json", :Authorization => authtoken)
    .get("https://api.lockstate.jp/models/" + "08d2bf38-a7b6-41a6-93dd-52021a267b57", :ssl_context => CTX)
    item = ActiveSupport::JSON.decode( res1.body )
    
    debugger
    render :getaccessuser
  end
  

  #設置場所
  def getlocation
    #AouthsetupControllerクラスのインスタンス化
    aouthctr = AouthsetupController.new
    accessToken = aouthctr.getAccessToken
    authtoken = "Bearer " + accessToken
    
    #取得
    res = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
    .get("https://api.lockstate.jp/locations/", :ssl_context => CTX)
    item = ActiveSupport::JSON.decode( res.body )
    data = item["data"]
    locationId = ""
    data.each do |location|
      locationId = location["id"]
    end
    
    #res = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
    #.get("https://api.lockstate.jp/locations/" + locationId, :ssl_context => CTX)
    #item = ActiveSupport::JSON.decode( res.body )
    
    #作成
    postbody = {
      "attributes": {
        "name": "LockState HQ",
        "phone": "(877) 254-5625",
        "address": "1325 S. Colorado Blvd",
        "address2": "Suite B400",
        "city": "Denver",
        "state": "CO",
        "postal_code": "80222",
        "country": "US",
        "time_zone": "America/Denver"
      }
    }
    
    #res = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
    #.post("https://api.lockstate.jp/locations", :ssl_context => CTX, :body => postbody.to_json)
    #item = ActiveSupport::JSON.decode( res.body )
    
    postbody2 = {
      "attributes": {
        "name": "LockState HQHQ"
      }
    }
    #res = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
    #.put("https://api.lockstate.jp/locations/" +  "0f844fe3-965e-4769-8936-972003f708e0", :ssl_context => CTX, :body => postbody2.to_json)
    #item = ActiveSupport::JSON.decode( res.body )
    
    res = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
    .delete("https://api.lockstate.jp/locations/" +  "0f844fe3-965e-4769-8936-972003f708e0", :ssl_context => CTX)
    
    
    debugger
    render :getaccessuser
  end
  
  
  #グループ
  def getgroup
    #AouthsetupControllerクラスのインスタンス化
    aouthctr = AouthsetupController.new
    accessToken = aouthctr.getAccessToken
    authtoken = "Bearer " + accessToken
    
    #取得
    res = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
    .get("https://api.lockstate.jp/groups/" + "d2b68ea2-c83b-4051-a3e8-28223ce4af24" + "/doors/" + "c744baed-9b63-4b73-bbcc-a5406ebdd8ae", :ssl_context => CTX)
    item = ActiveSupport::JSON.decode( res.body )
    
    #削除
    res = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
    .delete("https://api.lockstate.jp/groups/" + "cfcc46b9-0502-4cb7-a9f8-772c419db4e2" + "/doors/" + "e1dc9c97-aef0-457e-a183-ed0cbbd8a0e8", :ssl_context => CTX)
    
    debugger
    
    #作成/更新
    postbody = {
      "type": "door_group",
      "attributes": {
        "name": "ドアグループテスト"
      }
    }
    
    postbody2 = {
      "attributes": {
        "door_id": "acf0b607-0e15-4e95-aa58-b1c0455a0135",
        "door_type": "lock"
      }
    }
    
    #res = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
    #.post("https://api.lockstate.jp/groups/" + "cfcc46b9-0502-4cb7-a9f8-772c419db4e2" + "/doors", :ssl_context => CTX , :body => postbody2.to_json)
    #item = ActiveSupport::JSON.decode( res.body )
    
    #res = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
    #.put("https://api.lockstate.jp/groups/" + "4784848a-26e1-4b2e-a23d-bb427b306492", :ssl_context => CTX , :body => postbody.to_json)
    #item = ActiveSupport::JSON.decode( res.body )
    
    debugger
    render :getaccessuser
  end
  
  
  
  
  
  
  
  
  #イベント
  def getevent
    #AouthsetupControllerクラスのインスタンス化
    aouthctr = AouthsetupController.new
    accessToken = aouthctr.getAccessToken
    authtoken = "Bearer " + accessToken
    
    res = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
    .get("https://api.lockstate.jp/events/" + "18051a7a-4755-4f69-9199-2bf240bc20fd", :ssl_context => CTX)
    item = ActiveSupport::JSON.decode( res.body )
    debugger
    render :getaccessuser
  end
  
  #アカウント
  def getaccount
    #AouthsetupControllerクラスのインスタンス化
    aouthctr = AouthsetupController.new
    accessToken = aouthctr.getAccessToken
    authtoken = "Bearer " + accessToken
    
    res = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
    .get("https://api.lockstate.jp/account", :ssl_context => CTX)
    item = ActiveSupport::JSON.decode( res.body )
    
    postbody = {
      "attributes": {
        "name": "Demo User a",
        "default_guest_start_time": "15:30:00",
        "default_guest_end_time": "02:15:00"
      }
    }
    
    res1 = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken, "Accept" => "application/vnd.lockstate+json; version=1" )
    .put("https://api.lockstate.jp/account", :ssl_context => CTX , :body => postbody.to_json)
    
    render :getaccessuser
    
  end
  
  
  #デバイス
  def getdevice
    #AouthsetupControllerクラスのインスタンス化
    aouthctr = AouthsetupController.new
    accessToken = aouthctr.getAccessToken
    authtoken = "Bearer " + accessToken
    
    #設置場所の呼び出し
    res0 = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
    .get("https://api.lockstate.jp/locations", :ssl_context => CTX)
    item = ActiveSupport::JSON.decode( res0.body )
    data = item["data"]
    locationId = ""
    data.each do |location|
      locationId = location["id"]
    end
    
    #デバイス登録
    postbody = {
      "attributes": {
        "name": "テストデバイス",
        "serial_number": "AC000W000231365",
        "model_id": "08d2bf38-a7b6-41a6-93dd-52021a267b57",
        "location_id": locationId,
        "programming_code": "87654321"
      }
    }
    
    #res = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
    #.post("https://api.lockstate.jp/devices", :ssl_context => CTX, :body => postbody.to_json)
    
    #デバイス更新
    postbody = {
      "attributes": {
        "name": "テストデバイス2",
        "default_guest_start_time": "11:15:00",
        "power_source": "alkaline_battery",
        "local_pins": [
          "4321"
        ]
      }
    }
    
    #デバイスアクセス情報の取得
    res = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
    .get("https://api.lockstate.jp/devices/" + "3283c1f5-f318-4a7c-acaa-e74f5923b530/" + "access_person_accesses", :ssl_context => CTX)
    
    debugger
    
    #res = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
    #.get("https://api.lockstate.jp/devices", :ssl_context => CTX)
    #item = ActiveSupport::JSON.decode( res.body )
    
    #debugger
    
    #postbody = {
    #  "attributes": {
    #    "name": "Demo User a",
    #    "default_guest_start_time": "15:30:00",
    #    "default_guest_end_time": "02:15:00"
    #  }
    #}
    
    #res1 = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken, "Accept" => "application/vnd.lockstate+json; version=1" )
    #.put("https://api.lockstate.jp/account", :ssl_context => CTX , :body => postbody.to_json)
    #debugger
    
    render :getaccessuser
    
  end
  
  #アクセス不可日
  def getaccessexception
    #AouthsetupControllerクラスのインスタンス化
    aouthctr = AouthsetupController.new
    accessToken = aouthctr.getAccessToken
    authtoken = "Bearer " + accessToken
    
    #アクセス不可日の呼び出し
    res = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
    .get("https://api.lockstate.jp/access_exceptions", :ssl_context => CTX)
    item = ActiveSupport::JSON.decode( res.body )
    
    postbody = {
      "name": "Thanks Giving",
      "dates": [
        {
          "start_date": "2017-11-24",
          "end_date": "2017-11-25"
        }
      ]
    }
    
    #アクセス不可日の更新
    res1 = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken, "Accept" => "application/vnd.lockstate+json; version=1" )
    .put("https://api.lockstate.jp/access_exceptions/" + "ac684ef0-fabf-4842-921b-93220b2220cf", :ssl_context => CTX , :body => postbody.to_json)
    item1 = ActiveSupport::JSON.decode( res1.body )
    debugger
      
    #  #アクセス不可日の削除
    #  #res2 = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
    #  #.delete("https://api.lockstate.jp/access_exceptions/" + id, :ssl_context => CTX)
    
    #アクセス不可日の作成
    postbody = {
      "type": "access_exception",
      "name": "test",
      "dates": [
        {
          "start_date": "2017-11-24",
          "end_date": "2017-11-25"
        }
      ]
    }
    res2 = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken, "Accept" => "application/vnd.lockstate+json; version=1" )
    .post("https://api.lockstate.jp/access_exceptions", :ssl_context => CTX , :body => postbody.to_json)
    item2 = ActiveSupport::JSON.decode( res2.body )
    debugger
    
  end
  
  
  
  
  #アクセス不可日・アクセスユーザー/ゲスト
  def getaccessuser
    
    #AouthsetupControllerクラスのインスタンス化
    aouthctr = AouthsetupController.new
    accessToken = aouthctr.getAccessToken
    authtoken = "Bearer " + accessToken
    
    #設置場所の呼び出し
    res0 = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
    .get("https://api.lockstate.jp/locations", :ssl_context => CTX)
    item = ActiveSupport::JSON.decode( res0.body )
    data = item["data"]
    locationId = ""
    data.each do |location|
      locationId = location["id"]
    end
    
    #アクセスユーザーの呼び出し
    res = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
    .get("https://api.lockstate.jp/access_persons?type=access_guest&per_page=5", :ssl_context => CTX)
    
    item = ActiveSupport::JSON.decode( res.body )
    data = item["data"]
    data.each do |exception|
      id = exception["id"]
      
      #postbody = {
      #    "attributes": {
      #      "accessible_id": locationId,
      #      "accessible_type": "location",
      #    }
      #  }
        
      #apiUri = "https://api.lockstate.jp/access_persons/" + id + "/accesses"
      #res = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
      #.post(apiUri, :ssl_context => CTX , :body => postbody.to_json)
     
      #アクセスユーザーアクセスの呼び出し(ID指定)
      res3 = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
      .get("https://api.lockstate.jp/access_persons/" + id + "/accesses/", :ssl_context => CTX)
      item = ActiveSupport::JSON.decode( res3.body )
      data = item["data"]
      data.each do |access|
        #id2 = access["attributes"]["accessible_id"]
        id2 = access["id"]
        
        #postbody = {
        #  "attributes": {
        #    "access_schedule_id": "ca29030c-4cd2-4059-84fa-0a900a4a3f37"
        #  }
        #}
        #res = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
        #.put("https://api.lockstate.jp/access_persons/" + id + "/accesses/" + id2, :ssl_context => CTX, :body => postbody.to_json)
        #debugger
        
        #アクセスユーザーアクセスの削除
        res = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
        .delete("https://api.lockstate.jp/access_persons/" + id + "/accesses/" + id2, :ssl_context => CTX)
        
        debugger
        
      end
      
      debugger
      
      postbody = {
        "attributes": [
          {
            "name": "変更後"
          }
        ]
      }
      #アクセスユーザーの更新
      #res1 = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken, "Accept" => "application/vnd.lockstate+json; version=1" )
      #.put("https://api.lockstate.jp/access_persons/" + id + "/deactivate", :ssl_context => CTX , :body => postbody.to_json)
      
      res2 = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken, "Accept" => "application/vnd.lockstate+json; version=1" )
      .get("https://api.lockstate.jp/access_persons/" + id + "/email/preview", :ssl_context => CTX )
      
      #アクセス不可日の削除
      #res2 = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
      #.delete("https://api.lockstate.jp/access_exceptions/" + id, :ssl_context => CTX)
      
      debugger
      
    end
    
    
    #アクセス不可日の呼び出し
    res = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
    .get("https://api.lockstate.jp/access_exceptions", :ssl_context => CTX)
    item = ActiveSupport::JSON.decode( res.body )
    data = item["data"]
    data.each do |exception|
      id = exception["id"]
      
      
      #アクセス不可日の呼び出し(ID指定)
      res = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
      .get("https://api.lockstate.jp/access_exceptions/" + id, :ssl_context => CTX)
      
      postbody = {
        "dates": [
          {
            "start_date": "2017-11-24",
            "end_date": "2017-11-25"
          }
        ]
      }
      #アクセス不可日の更新
      res1 = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken, "Accept" => "application/vnd.lockstate+json; version=1" )
      .put("https://api.lockstate.jp/access_exceptions/" + id, :ssl_context => CTX , :body => postbody.to_json)
      
      #アクセス不可日の削除
      #res2 = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
      #.delete("https://api.lockstate.jp/access_exceptions/" + id, :ssl_context => CTX)
      
      debugger
      
    end
    
    
    #アクセス不可日の作成
    postbody = {
      "name": "不可日テスト",
      "dates": [
        {
          "start_date": "2017-11-24",
          "end_date": "2017-11-25"
        }
      ]
    }
    
    #res1 = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
    #.post("https://api.lockstate.jp/access_exceptions", :ssl_context => CTX, :body => postbody.to_json)
    res1 = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken, "Accept" => "application/vnd.lockstate+json; version=1" )
    .post("https://api.lockstate.jp/access_exceptions", :ssl_context => CTX , :body => postbody.to_json)
    
    
    
    debugger
    
    #アクセスユーザー/ゲストの作成
    #postbody1 = {
    #    "type": "access_guest",
    #    "attributes": {
    #     "starts_at": "2017-10-02T11:50:00",
    #      "ends_at":"2017-10-02T13:10:00",
    #      "name": "name5",
    #      "generate_pin": true,
    #    }
    #  }
      
    #postbody1 = {
    #    "type": "access_user",
    #    "attributes": {
    #      "name": "name4",
    #      "generate_pin": true,
    #    }
    #  }
    
    #authtoken = "Bearer "+ accessToken
    #res1 = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken, "Accept" => "application/vnd.lockstate+json; version=1" )
    #.post("https://api.lockstate.jp/access_persons", :ssl_context => CTX , :body => postbody1.to_json)
    
    #戻り値をJson形式に変換
    #item = ActiveSupport::JSON.decode( res.body )
    #puts("item")
    #puts(item)
    
    #配列で渡す
    #現在時刻
    nowtime = DateTime.current
    @time = nowtime
    
    #@guests = item["data"]
    
  end
  
  
  #アクセスゲスト作成
  def createUser 
    #AouthsetupControllerクラスのインスタンス化
    aouthctr = AouthsetupController.new
    accessToken = aouthctr.getAccessToken
    authtoken = "Bearer " + accessToken
    
    postbody = {
      "type": "access_user",
      "attributes": {
        "name": "test",
        "generate_pin": true,
      }
    }
    res = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken )
    .post("https://api.lockstate.jp/access_persons", :ssl_context => CTX , :body => postbody.to_json)
    item = ActiveSupport::JSON.decode( res.body )
    
    if res.code==200
      @state = "認証に成功しました"
    end
    
    render :getaccessuser
    
  end
  
  #エラー一覧
  def errors
    #AouthsetupControllerクラスのインスタンス化
    aouthctr = AouthsetupController.new
    accessToken = aouthctr.getAccessToken
    authtoken = "Bearer " + accessToken
    
    #アクセス不可日の更新→NG　400エラー→attributesで解決！
    postbody1 = {
      "attributes": {
        "name": "Thanks Giving and Christmas",
        "dates": [
          {
            "start_date": "2017-11-24",
            "end_date": "2017-11-25"
          },
          {
            "start_date": "2018-12-25",
            "end_date": "2018-12-25"
          }
        ]
      }
    }
    res1 = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken, "Accept" => "application/vnd.lockstate+json; version=1" )
    .put("https://api.lockstate.jp/access_exceptions/" + "ac684ef0-fabf-4842-921b-93220b2220cf", :ssl_context => CTX , :body => postbody1.to_json)
    item1 = ActiveSupport::JSON.decode( res1.body )
    
    #アクセス不可日の作成→NG　400エラー→attributesで解決！
    postbody2 = {
      "attributes": {
        "name": "不可日テスト",
        "dates": [
          {
            "start_date": "2017-11-24",
            "end_date": "2017-11-25"
          }
        ]
      }
    }
    res2 = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken, "Accept" => "application/vnd.lockstate+json; version=1" )
    .post("https://api.lockstate.jp/access_exceptions", :ssl_context => CTX , :body => postbody2.to_json)
    item2 = ActiveSupport::JSON.decode( res2.body )
    
    #アクセスユーザーの更新→NG　500エラー
    postbody3 = {
    "attributes":
      {
        "name": "kozo-taro"
      }
    }
    res3 = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken, "Accept" => "application/vnd.lockstate+json; version=1" )
    .put("https://api.lockstate.jp/access_persons/" + "3c2d40a7-b47e-472b-98a9-9dac928843ec", :ssl_context => CTX , :body => postbody3.to_json)
    item3 = ActiveSupport::JSON.decode( res3.body )
    debugger
    
    #アクセスユーザーアクセスの呼び出し(ID指定)→OK
    res = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
    .get("https://api.lockstate.jp/access_persons/" + "63c1a510-9e75-4199-a3ea-4b0179644498" + "/accesses/", :ssl_context => CTX)
    item = ActiveSupport::JSON.decode( res.body )
    data = item["data"]
    data.each do |access|
      id2 = access["id"]
      #アクセスユーザー/アクセススケジュールの更新
      postbody4 = {
        "attributes": {
        "access_schedule_id": "ca29030c-4cd2-4059-84fa-0a900a4a3f37"
        }
      }
      res4 = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
      .put("https://api.lockstate.jp/access_persons/" + "63c1a510-9e75-4199-a3ea-4b0179644498" + "/accesses/" + id2, :ssl_context => CTX, :body => postbody4.to_json)
      item4 = ActiveSupport::JSON.decode( res4.body )
    end
    
    #ドアグループの取得→OK
    res5 = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
    .get("https://api.lockstate.jp/groups/" + "614f146e-f993-4ceb-9fb1-2ada6a4f5455" + "/doors/" + "f2d0eca4-eb1c-44bd-96d6-287ccbaa0afc", :ssl_context => CTX)
    #"c744baed-9b63-4b73-bbcc-a5406ebdd8ae"
    item5 = ActiveSupport::JSON.decode( res5.body )
    
    #ドアグループの削除→OK
    res6 = HTTP.headers("Content-Type" => "application/json",:Authorization => authtoken)
    .delete("https://api.lockstate.jp/groups/" + "614f146e-f993-4ceb-9fb1-2ada6a4f5455" + "/doors/" + "f2d0eca4-eb1c-44bd-96d6-287ccbaa0afc", :ssl_context => CTX)
    #item6 = ActiveSupport::JSON.decode( res6.body )
    
    
  end
  
  
  
end
