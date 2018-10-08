//
//  DEBUGLOG.h
//  TaoJin
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 YueBao. All rights reserved.
//

#ifndef DEBUGLOG_h
#define DEBUGLOG_h

#ifdef DEBUG
#define DEBUGLOG NSLog
#else
#define DEBUGLOG
#endif

#endif /* DEBUGLOG_h */
