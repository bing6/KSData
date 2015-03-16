   [KS_GET_DEF_CONFIG_SHARED() initializeDatabase];
    
    DLog(@"%@", [KS_GET_DEF_CONFIG_SHARED() dbPath]);
    
    id dao = KS_GET_DEF_DAO_INSTANCE();
    
    KSUserEntity * ue1 = [KSUserEntity new];
    
    ue1.userID = 900;
    ue1.userName = @"小明";
    ue1.userAvatar = @"http://image.baidu.com/detail/newindex?col=%E5%8A%A8%E6%BC%AB&tag=%E5%85%A8%E9%83%A8&pn=10&pid=9352809633&aid=&user_id=129439738&setid=-1&sort=1&newsPn=&star=&fr=&from=1";
    
    KSUserEntity * ue3 = [KSUserEntity new];
    
    ue3.userID = 902;
    ue3.userName = @"小黑";
    ue3.userAvatar = @"http://image.baidu.com/detail/newindex?col=%E5%8A%A8%E6%BC%AB&tag=%E5%85%A8%E9%83%A8&pn=10&pid=9352809633&aid=&user_id=129439738&setid=-1&sort=1&newsPn=&star=&fr=&from=1";
    
    id ue2 = @{ @"userID" : @(901), @"userName" : @"小红", @"userAvatar" : @"nothing" };
    
    KS_DB_INSERT_1(dao, KS_S_KSUSER_INSERT_SINGLE, ue1);
    KS_DB_INSERT_1(dao, KS_S_KSUSER_INSERT_SINGLE, ue2);
    KS_DB_INSERT_1(dao, KS_S_KSUSER_INSERT_SINGLE, ue3);
    
    
    NSArray * result = KS_DB_QUERY_LIST_2(dao, KS_S_KSUSER_SELECT_ALL, nil);
    
    DLog(@"%@", result);
    
    KSUserEntity * rsin = KS_DB_QUERY_OBJECT_2(dao, KS_S_KSUSER_SELECT_SINGLE, @(900));
    
    DLog(@"%@", rsin);
    
    KS_DB_CONN_RELEASE(dao);
