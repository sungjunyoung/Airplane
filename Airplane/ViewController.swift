//
//  ViewController.swift
//  Airplane
//
//  Created by junyoung on 2016. 5. 19..
//  Copyright © 2016년 tgwing. All rights reserved.
//

import UIKit



extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

class ViewController: UIViewController{
    @IBOutlet weak var signinBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var emailTextBox: UITextField!
    @IBOutlet weak var passwordTextBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        //키보드 뜨는지
        self.hideKeyboardWhenTappedAround()
    
        var userData : String = ""
        var postData : String = ""
        if(UserManager.userList.count == 0){ //첫 실행일 경우 텍스트로
            userData = "0/a/a/공병국/경희대학교/1,3,4,11,13,16,19/2,6\n1/goduddh@naver.com/1111/오해영/아주대학교/0,5,6,14/7,2\n2/hardsizin@daum.net/2222/유시진/우르크대학교/7,8,4/-1\n3/whemfwhemf@gmail.com/3333/조들호/금산대학교/0/4,6,17\n4/z/z/성준영/경희대학교/0,12,2,10,11,16/-1\n5/protpgh@naver.com/5555/조세호/불참대학교/1,6,9,18/-1\n6/sun1991@naver.com/6666/김용선/솔라대학교/1,5,18/0\n7/ryujuns2@gmail.com/7777/류준열/덕선대학교/2,0,15,18/-1\n8/shinegml@naver.com/8888/황광희/무한대학교/2,14/6,7,5,3\n9/eric0089@naver.com/9999/박도경/오해대학교/5/2\n10/1li2016@naver.com/1010/에일리/복면대학교/4,15,19/-1\n11/cksdncks14@naver.com/1111/김찬우/경희대학교/0,4/16\n12/jungummmm@daum.net/1212/황정음/운빨대학교/4,7,9,16/11\n13/nayeon1992@naver.com/1313/임나연/JYP대학교/0,2,10,16/5\n14/dmsqltlsql@naver.com/1414/황은비/신비대학교/2,8,15/4,11,13\n15/dbsk169@naver.com/1515/최유나/유주대학교/14,7,10,16/0,11\n16/leetprn@yahoo.co.kr/1616/이세구/경희대학교/0,4,12,13,15/8\n17/gusdnha@gmail.com/1717/하현우/대장대학교/18/0,1,6,10,13,14,15,16\n18/leesu@daum.net/1818/이수현/악동대학교/5,6,7,17/-1\n19/rapperwlals@naver.com/1919/신지민/아오아대학교/0,10/4,5,8,2,15"
            postData = "0/0/2016.05.12.12.32/SNS 시작했습니다. 친구 요청 많이주세요!\n1/2/2016.05.14.01.26/안녕하세요.\n2/1/2016.05.16.03.48/나 때문에 울게 될거야...\n3/8/2016.05.21.06.53/무한 도전! 특집 촬영중!\n4/4/2016.05.21.18.22/시진아 9시에 약속 알고있지?\n5/6/2016.05.25.16.24/경희대 축제가 제일 대박이야!\n6/0/2016.05.25.22.57/마마무 공연 대박 ㅋㅋ\n7/7/2016.05.25.23.55/아... 덕선이 보고싶다 ㅜㅜ\n8/9/2016.05.26.02.35/진짜 그 여자 때문에 울거같아요.\n9/2/2016.05.26.02.36/들호형 한잔 해요.\n10/5/2016.05.27.09.24/초대 받지도 않았는데 경희대 축제를 가야해?\n11/5/2016.05.27.11.52/경희대 축제가 제일 핫하다는데 가볼까...\n12/4/2016.05.27.14.57/조세호는 글렀어 ㅎㅎ\n13/2/2016.05.27.15.23/준영아 축제때 안주 많이 주냐?\n14/10/2016.05.27.19.25/주냉? 나 티지윙 주점인데 너 안보여 놀러갔냐? 실망이다?\n15/2/2016.05.27.19.32/아... 에일리누나 나 물 사오는 중이야. 기다려 내가 서비스 쫙 넣어줄테니까!\n16/19/2016.05.28.01.32/SNS 시작해요~ 친구 추가 많이 해주세요.\n17/17/2016.05.28.01.33/힘든데 누가 좀 이겨주면 안되나...\n18/17/2016.05.28.02.22/아 너무 건방졌나...? 근데 이기는걸 어떻게해 ㅎㅎ\n19/15/2016.05.28.02.43/웹툰으로 시간을 달렸다 ㅎㄷㄷ\n20/18/2016.05.28.02.56/미련없이 손을 흔들어 리바이~ 많이 사랑해주세요!\n21/13/2016.05.28.04.31/아는형님 트와이스편 많이 시청해주세요~\n22/12/2016.05.28.09.12/아 어제 괜히 띠드버거 머꼬자땅... 눈 부었또 ㅜ\n23/0/2016.05.28.09.24/프로젝트 월케 많아 ㅡㅡ...\n24/4/2016.05.28.09.56/와 주점으로 개이득냄... 회식하자 ㅋㅋㅋㅋ\n25/11/2016.05.28.10.09/준영형 저도 회식 껴주세요~\n26/10/2016.05.28.10.21/술 몇일 째 먹었더니 눈이 안떠지네... 몸 생각해야지 ㅜ\n27/1/2016.05.28.10.34/너 때문에 미쳐버릴것 같아서 누구라도 필요해...\n28/5/2016.05.28.10.57/축가는 프로불참러의 불명옌데 딥빡 ㅋㅋㅋㅋㅋ\n29/6/2016.05.28.11.01/코마니코마니~\n30/3/2016.05.28.11.36/정금모 너 이제 진짜 끝났어 ㅋㅋㅋㅋㅋㅋㅋ 터진다 리스트 ㅋㅋㅋ\n31/13/2016.05.28.11.37/시진 오빠 보고싶다!!!!\n32/2/2016.05.28.11.44/서대영이 혼자 치사하게 간식 먹는거 그거 아니지 말입니다?\n33/7/2016.05.28.12.06/내 신경은 온통 운빨로맨스 ㅇㄷㅇ;;\n34/9/2016.05.28.12.10/돌아버리겠네... 너무 좋은데 좋다고 말할 수가 없어 미치겠다.\n35/4/2016.05.28.12.56/에일리 누나 싸랑해요!\n36/10/2016.05.28.12.59/성준영 갑자기 왜 저래 미쳤나? ㅋㅋㅋㅋㅋ\n37/4/2016.05.28.13.09/는 구라\n38/14/2016.05.28.13.24/신비 오늘 콘서트 있또요! 많이 놀러오세요~ 지갑 필참\n39/8/2016.05.28.14.54/ㅇㅎ 신비? 오빠 놀러간다 기다려 ㅋㅋㅋ\n40/14/2016.05.28.15.22/?! 오빠 바쁘다면서요 ㅡㅡ (빠직)\n41/17/2016.05.28.15.39/No Win No Life 승리없는 인생없다. Haaahaha\n42/12/2016.05.28.15.42/오늘 습하고 너무 더! 워요~\n43/6/2016.05.28.15.59/코마니!! 코마니이이이이이~\n44/19/2016.05.28.16.22/병꾸꾸 누나 오늘 강남 가는데 얼굴이나 볼까?\n45/0/2016.05.28.16.48/ㅈㅅ 오늘 프로젝트 해야함 담에 봐ㅋㅋㅋㅋ\n46/19/2016.05.28.18.11/ㅡㅡ 꺼져 내가 안봐\n47/4/2016.05.28.18.29/헐 체육대회 회의 언제하지...?\n48/16/2016.05.28.18.30/어짜피 롤 대회 우승은 티지윙!\n49/0/2016.05.28.18.56/ㅋㅋㅋ 그리고 광탈 세구 김칫국 ㄴㄴㄴ 연습해 ㅋㅋ\n50/6/2016.05.28.19.00/코마닝코마니!!"///////////////////////////////////////유저데이터 어레이, 해시테이블 + 포스트 어레이 만들기//////////////////////////////////////
            let rawPostList:[NSString] = postData.componentsSeparatedByString("\n")
            let rawUserList:[NSString] = userData.componentsSeparatedByString("\n")
            var userPostList = Array<Array<Post>>()
            
            for _ in rawUserList{
                userPostList.append(Array<Post>())
            }
            
            for post in rawPostList{
                var postSplit:[NSString] = post.componentsSeparatedByString("/")
                let post = Post()
                post.index = Int(postSplit[0] as String)!
                post.userIndex = Int(postSplit[1] as String)!
                post.date = postSplit[2] as String!
                post.content = postSplit[3] as String!
                
                
                UserManager.postList.append(post)
                userPostList[post.userIndex].append(post)
            }
            
            
            var userList = Array<User>()
            for user in rawUserList {
                var userSplit:[NSString] = user.componentsSeparatedByString("/")
                
                let stringIndex:String = userSplit[0] as String
                let index = Int(stringIndex)!
                let email = userSplit[1] as String
                let password = userSplit[2] as String
                let name = userSplit[3] as String
                let group = userSplit[4] as String
                
                let rawFriendList:[NSString] = userSplit[5].componentsSeparatedByString(",")
                let rawRequestList:[NSString] = userSplit[6].componentsSeparatedByString(",")
                
                var friendList = Array<Int>()
                var requestList = Array<Int>()
                
                for friend in rawFriendList{
                    let stringFriend = friend as String
                    friendList.append(Int(stringFriend)!)
                }
                for request in rawRequestList{
                    let stringRequest = request as String
                    requestList.append(Int(stringRequest)!)
                }
                
                let user = User(index: index,email: email,password: password,name: name,group: group,friendList: friendList,requestList: requestList, postList: userPostList[index])
                userList.append(user)
            } // 유저데이터 어레이
            
            //이메일 해시테이블 생성
            var emailHashTable = Array<Array<User>>()
            var tempList1 = Array<User>()
            for (var i=0; i<1000 ; i++){
                emailHashTable.append(tempList1)
            }
            
            for user in userList{
                var sum = 0
                for character in user.email.utf8{
                    let stringSegment:String = "\(character)"
                    sum += Int(stringSegment)!
                }
                sum = sum % 1000
                
                emailHashTable[sum].append(user)
                emailHashTable[sum].sortInPlace{(user1:User, user2:User)->Bool in user1.email < user2.email}
            }
            
            //이름 해시테이블 생성
            var nameHashTable = Array<Array<User>>()
            var tempList2 = Array<User>()
            for _ in 0..<1000 {
                nameHashTable.append(tempList2)
            }
            
            for user in userList{
                var sum = 0
                for character in user.name.utf8{
                    let stringSegment:String = "\(character)"
                    sum += Int(stringSegment)!
                }
                sum = sum % 1000
                nameHashTable[sum].append(user)
                nameHashTable[sum].sortInPlace{(user1:User, user2:User)->Bool in user1.name < user2.name}
            }
            
            
            
            //해시테이블에 잘 들어갓나 확인
            print("이메일")
            var i = 0 , j = 0
            for userLi in emailHashTable{
                j=0
                for user in userLi{
                    print(i," ",j," ",user.email)
                    j+=1
                }
                i+=1
            }
            print("이름")
            i = 0
            for userLi in nameHashTable{
                j = 0
                for user in userLi{
                    print(i," ",j," ",user.name)
                    j+=1
                }
                i+=1
            }
            
            UserManager.userList = userList
            UserManager.emailHashTable = emailHashTable
            UserManager.nameHashTable = nameHashTable
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            
        }
        else{ // 아닐경우 파일로 읽어온다.
            FileManager.updateUserFile(UserManager.userList, postList: UserManager.postList)
            let userDataTxt = "userdata.txt" //this is the file. we will write to and read from it
            let postDataTxt = "postdata.txt"
            if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
                let userPath = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(userDataTxt)
                let postPath = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(postDataTxt)
                //reading
                do {
                    userData = try NSString(contentsOfURL: userPath, encoding: NSUTF8StringEncoding) as String
                    postData = try NSString(contentsOfURL: postPath, encoding: NSUTF8StringEncoding) as String
                }
                catch {/* error handling here */}
            }
        }
        
        
    }
    
    @IBAction func signin(sender: AnyObject) {
        let tempUser:User = UserManager.findByEmail(self.emailTextBox!.text!)
        // 해시테이블에서 유저를 찾아 로그인 하게한다.
        
        if tempUser.index == -1{ // 유저를 찾지 못햇다면
            print("incorrect email")
            userIncorrectAlert()
        }
        else{
            if tempUser.password == self.passwordTextBox!.text!{
                //이메일과 패스워드가 모두 일치 할 때 로그인 가능
                UserManager.nowUser = tempUser // 현재 유저 설정
                self.performSegueWithIdentifier("segMain", sender: self)
            }
            else {
                print("incorrect password")
                userIncorrectAlert()
            }
        }
    }
    
    func userIncorrectAlert(){
        let alert = UIAlertController(title: "회원정보 불일치", message: "회원 정보를 확인해 주세요", preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancel = UIAlertAction(title: "확인", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alert.addAction(cancel)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    

    @IBAction func signup(sender: AnyObject) {
        self.performSegueWithIdentifier("segSignup", sender: self)
        
    }

    //keyboard Show
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150
    }
    
    //keyboard Hide
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
}

