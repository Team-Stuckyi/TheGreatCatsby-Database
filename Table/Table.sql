/* 테이블 생성 SQL */


/* 관리자 정보 테이블 */
CREATE TABLE `admins` (
  `user_id` int NOT NULL AUTO_INCREMENT COMMENT '일련번호',
  `email` varchar(40) NOT NULL COMMENT '회원 이메일',
  `password` varchar(500) NOT NULL COMMENT '비밀번호',
  `name` varchar(20) NOT NULL COMMENT '이름',
  `status` enum('Y','N') NOT NULL COMMENT '계정 상태',
  `tel` varchar(11) DEFAULT NULL COMMENT '휴대전화',
  `reg_date` datetime NOT NULL COMMENT '가입일자',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='관리자 정보 테이블';

/* 사용자 정보 테이블 */
CREATE TABLE `members` (
  `user_id` int NOT NULL AUTO_INCREMENT COMMENT '일련번호',
  `email` varchar(40) NOT NULL COMMENT '회원 이메일',
  `password` varchar(500) NOT NULL COMMENT '비밀번호',
  `name` varchar(20) NOT NULL COMMENT '이름',
  `status` enum('Y','N') NOT NULL COMMENT '계정 상태',
  `tel` varchar(11) DEFAULT NULL COMMENT '휴대전화',
  `addr1` varchar(100) DEFAULT NULL COMMENT '우편번호 api로 받은 주소',
  `addr2` varchar(100) DEFAULT NULL COMMENT '상세 주소',
  `reg_date` datetime NOT NULL COMMENT '가입일자',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사용자 정보 테이블';

/* 상품 정보 테이블 */
CREATE TABLE `products` (
  `prod_id` int NOT NULL AUTO_INCREMENT COMMENT '일련번호',
  `name` varchar(40) NOT NULL COMMENT '상품명',
  `stock` int NOT NULL COMMENT '재고',
  `status` enum('Y','N') NOT NULL COMMENT '판매 가능 여부',
  `price` int NOT NULL COMMENT '판매 가격',
  `category` varchar(15) NOT NULL COMMENT '카테고리',
  `thumbnail_photo` varchar(500) NOT NULL COMMENT '상품 썸네일 사진',
  `info_photo` varchar(500) NOT NULL COMMENT '상품 정보 사진',
  `prod_info` varchar(500) NOT NULL COMMENT '상품 정보 설명',
  `prod_feature` varchar(500) NOT NULL COMMENT '상품 특징',
  `reg_date` datetime NOT NULL COMMENT '상품 등록 날짜',
  `review_count` int DEFAULT NULL COMMENT '리뷰 갯수',
  `stars_avg` float DEFAULT NULL COMMENT '평점',
  PRIMARY KEY (`prod_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품 정보 테이블';

/* 주문 내역 테이블 */
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT COMMENT '일련번호',
  `order_price` int NOT NULL COMMENT '판매가+배송비',
  `order_date` datetime NOT NULL COMMENT '주문 날짜',
  `order_select` enum('T','K') NOT NULL COMMENT '결제 방식',
  `order_count` int NOT NULL COMMENT '상품 수량',
  `order_status` enum('Y','N') NOT NULL COMMENT '주문 상태',
  `prod_id` int NOT NULL COMMENT '상품 일련번호',
  `user_id` int NOT NULL COMMENT '회원 일련번호',
  PRIMARY KEY (`order_id`),
  KEY `fk_orders_prod_id` (`prod_id`),
  KEY `fk_orders_user_id` (`user_id`),
  CONSTRAINT `fk_orders_prod_id` FOREIGN KEY (`prod_id`) REFERENCES `products` (`prod_id`),
  CONSTRAINT `fk_orders_user_id` FOREIGN KEY (`user_id`) REFERENCES `members` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='주문 내역 테이블';

/* 리뷰 정보 테이블 */
CREATE TABLE `reviews` (
  `review_id` int NOT NULL AUTO_INCREMENT COMMENT '일련번호',
  `review_text` varchar(500) NOT NULL COMMENT '리뷰 내용',
  `review_photo` varchar(500) DEFAULT NULL COMMENT '리뷰 사진',
  `stars` int NOT NULL COMMENT '평점',
  `write_date` datetime NOT NULL COMMENT '작성 날짜',
  `order_id` int NOT NULL COMMENT '구매 일련번호',
  PRIMARY KEY (`review_id`),
  KEY `fk_review_order_id` (`order_id`),
  CONSTRAINT `fk_review_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='리뷰 정보 테이블';
