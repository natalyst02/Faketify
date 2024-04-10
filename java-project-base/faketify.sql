-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.32-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for faketify
DROP DATABASE IF EXISTS `faketify`;
CREATE DATABASE IF NOT EXISTS `faketify` /*!40100 DEFAULT CHARACTER SET armscii8 COLLATE armscii8_bin */;
USE `faketify`;

-- Dumping structure for table faketify.album
DROP TABLE IF EXISTS `album`;
CREATE TABLE IF NOT EXISTS `album` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `release_year` int(11) DEFAULT NULL,
  `image` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table faketify.album: ~7 rows (approximately)
DELETE FROM `album`;
INSERT INTO `album` (`id`, `title`, `release_year`, `image`, `created_at`) VALUES
	(1, 'Lover', 2019, 'https://images2.imgbox.com/e1/eb/RXCUBUkq_o.jpg', '2023-12-26 09:43:57'),
	(2, 'Speak Now (Taylor\'s Version)', 2023, 'https://images2.imgbox.com/49/c0/nBq8rby5_o.jpg', '2023-12-26 10:03:35'),
	(3, 'Cornelia Street (Live From Paris)', 2020, 'https://images2.imgbox.com/a3/ae/JDmXZzhS_o.jpg', '2023-12-26 10:14:58'),
	(4, 'Sau Tấm Rèm (Single)', 2023, 'https://images2.imgbox.com/f8/b6/hd1r8Joh_o.jpg', '2023-12-26 10:22:40'),
	(5, 'Nàng (Single)', 2023, 'https://images2.imgbox.com/22/2b/Qdmt62Qy_o.jpg', '2023-12-26 10:27:27'),
	(6, 'Hollywood\'s Bleeding', 2019, 'https://images2.imgbox.com/b3/a4/BxDoO4VZ_o.jpg', '2023-12-26 10:39:19'),
	(7, '99%', 2023, 'https://images2.imgbox.com/aa/0b/cydZDzUv_o.jpg', '2023-12-26 10:39:19');

-- Dumping structure for table faketify.album_song
DROP TABLE IF EXISTS `album_song`;
CREATE TABLE IF NOT EXISTS `album_song` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `album_id` int(11) DEFAULT NULL,
  `song_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `album_id` (`album_id`),
  KEY `song_id` (`song_id`),
  CONSTRAINT `album_song_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`id`),
  CONSTRAINT `album_song_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `song` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table faketify.album_song: ~30 rows (approximately)
DELETE FROM `album_song`;
INSERT INTO `album_song` (`id`, `album_id`, `song_id`, `created_at`) VALUES
	(1, 1, 1, '2023-12-26 09:52:37'),
	(2, 1, 2, '2023-12-26 09:52:44'),
	(3, 1, 3, '2023-12-26 09:53:24'),
	(4, 1, 4, '2023-12-26 09:55:44'),
	(5, 2, 5, '2023-12-26 10:10:33'),
	(6, 2, 6, '2023-12-26 10:10:45'),
	(7, 2, 7, '2023-12-26 10:10:57'),
	(8, 2, 8, '2023-12-26 10:11:07'),
	(9, 2, 9, '2023-12-26 10:11:29'),
	(10, 3, 10, '2023-12-26 10:15:46'),
	(11, 4, 11, '2023-12-26 10:22:55'),
	(12, 5, 12, '2023-12-26 10:27:36'),
	(13, 5, 13, '2023-12-26 10:27:44'),
	(14, 6, 14, '2023-12-26 10:49:38'),
	(15, 6, 15, '2023-12-26 10:49:50'),
	(16, 6, 16, '2023-12-26 10:50:02'),
	(17, 6, 17, '2023-12-26 10:50:10'),
	(18, 7, 18, '2023-12-26 10:50:10'),
	(19, 7, 19, '2023-12-26 10:50:10'),
	(20, 7, 20, '2023-12-26 10:50:10'),
	(21, 7, 21, '2023-12-26 10:50:10'),
	(22, 7, 22, '2023-12-26 10:50:10'),
	(23, 7, 23, '2023-12-26 10:50:10'),
	(24, 7, 24, '2023-12-26 10:50:10'),
	(25, 7, 25, '2023-12-26 10:50:10'),
	(26, 7, 26, '2023-12-26 10:50:10'),
	(27, 7, 27, '2023-12-26 10:50:10'),
	(28, 7, 28, '2023-12-26 10:50:10'),
	(29, 7, 29, '2023-12-26 10:50:10'),
	(30, 7, 30, '2023-12-26 10:50:10');

-- Dumping structure for table faketify.artist
DROP TABLE IF EXISTS `artist`;
CREATE TABLE IF NOT EXISTS `artist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `avatar` text DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `founded_year` varchar(5) DEFAULT NULL,
  `band_member` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table faketify.artist: ~4 rows (approximately)
DELETE FROM `artist`;
INSERT INTO `artist` (`id`, `name`, `description`, `avatar`, `type`, `founded_year`, `band_member`, `created_at`) VALUES
	(1, 'Taylor Swift', 'Taylor Alison Swift (sinh ngày 13 tháng 12 năm 1989), thường được biết đến với nghệ danh Taylor Swift, là một nữ ca sĩ, nhạc sĩ sáng tác ca khúc, nhà sản xuất thu âm, doanh nhân, nhà làm phim kiêm diễn viên người Mỹ. Những sáng tác đa thể loại và cách viết lời theo hướng tự sự của cô đã nhận được sự tán dương của truyền thông và giới chuyên môn. Sinh ra tại West Reading, Pennsylvania, Swift chuyển đến Nashville, Tennessee ở tuổi 14 nhằm theo đuổi sự nghiệp nhạc đồng quê. Cô đã ký hợp đồng sáng tác với Sony/ATV Music Publishing vào năm 2004 và hợp đồng thu âm với Big Machine Records vào năm 2005, đồng thời phát hành album phòng thu đầu tay cùng tên vào năm 2006.\n\nCô khám phá dòng nhạc pop đồng quê trong album phòng thu thứ hai và thứ ba, Fearless (2008) và Speak Now (2010). Thành công của hai đĩa đơn "Love Story" và "You Belong with Me" đã đưa Swift trở thành nghệ sĩ crossover hàng đầu. Cô đã thử nghiệm nhiều thể loại nhạc gồm pop, rock và điện tử trong album phòng thu thứ tư của mình, Red (2012). Album phòng thu thứ 5 của cô thuộc thể loại synth-pop 1989 (2014), biến Swift từ một ca sĩ nhạc đồng quê thành ngôi sao nhạc pop, với các đĩa đơn quán quân Billboard Hot 100 bao gồm "Shake It Off", "Blank Space" và "Bad Blood". Sự soi mói của giới truyền thông đối với đời sống cá nhân của Swift đã truyền cảm hứng cho album phòng thu thứ sáu, Reputation (2017), đi sâu vào âm hưởng urban.\n\nSau khi chia tay Big Machine và ký hợp đồng với Republic Records vào năm 2018, Swift phát hành album phòng thu thứ bảy của cô, Lover (2019). Sau những thành công thương mại trong thập niên 2010, cô đã mạnh dạn theo đuổi dòng nhạc indie folk và alternative rock trong các album phòng thu năm 2020, Folklore và Evermore, với chất trữ tình, lấy cảm hứng từ chủ nghĩa thoát ly trong đại dịch COVID-19. Bộ đôi album được giới phê bình khen ngợi vì cách kể chuyện đầy sắc thái. Album Midnights (2022) của cô và đĩa đơn "Anti-Hero" đã phá vỡ nhiều kỷ lục âm nhạc. Để giành được quyền sở hữu bản gốc các tác phẩm cũ của bản thân, Swift đã tự tái thu âm sáu album đầu tiên của mình, và hiện đã phát hành bốn album tái thu âm dưới tên gọi "Taylor\'s Version". Bên cạnh âm nhạc, Swift đã có nhiều vai diễn khác nhau trong các bộ phim như Ẩn số tình yêu (2010), Cats: Những chú mèo (2019) và Amsterdam - Vụ án mạng kỳ bí (2022). Cô đã phát hành bộ phim tài liệu tự thuật Miss Americana (2020), và các bộ phim âm nhạc do cô tự đạo diễn gồm Folklore: The Long Pond Studio Sessions (2020) và All Too Well: The Short Film (2021).\n\nVới hơn 200 triệu đĩa nhạc được bán chạy trên toàn thế giới, Swift là một trong những nghệ sĩ âm nhạc bán đĩa nhạc chạy nhất mọi thời đại. Chín trong số những bài hát của cô đã đạt vị trí quán quân trên Billboard Hot 100, và các chuyến lưu diễn của cô là một trong số những tour diễn có doanh thu cao nhất trong lịch sử. Cô đã nhận được 12 giải Grammy (trong đó có 3 giải Album của năm), 1 giải Emmy, 29 giải thưởng Âm nhạc Billboard (nữ nghệ sĩ giành nhiều giải nhất), 40 giải thưởng Âm nhạc Mỹ (nghệ sĩ nhận nhiều giải nhất), 92 kỷ lục Guinness thế giới, và nhiều giải thưởng khác. Cô góp mặt trong danh sách 100 nhạc sĩ vĩ đại nhất mọi thời đại (2015) của Rolling Stone, đứng thứ 8 trong danh sách Nghệ sĩ xuất sắc nhất mọi thời đại của Billboard (2019) và nhiều lần xuất hiện trong các bảng xếp hạng quyền lực như Time 100 và Forbes Celebrity 100. Được Billboard vinh danh là Người phụ nữ của thập niên 2010 và được Giải thưởng Âm nhạc Mỹ trao tặng giải Nghệ sĩ của thập niên 2010, Swift được coi là một biểu tượng đại chúng do sự nghiệp đầy sức ảnh hưởng của cô, hoạt động từ thiện, ủng hộ quyền nghệ sĩ và trao quyền cho phụ nữ trong ngành công nghiệp âm nhạc.', 'https://images2.imgbox.com/e6/f6/1V0laTql_o.jpg', NULL, '2004', NULL, '2023-12-14 02:59:24'),
	(2, 'NGHI', 'NGHI, thường được biết tới là Gia Nghi, là một nữ ca sĩ/nhạc sĩ trẻ tài năng đến từ thành phố Long Xuyên, An Giang, Việt Nam. Cô được biết tới nhiều khi trở thành Á Quân The Voice Việt Nam 2018.\n\nSau khi chương trình The Voice Việt Nam 2018 kết thúc, NGHI tiếp tục quay lại hành trình học vấn của mình tại trường đại học Kiến Trúc Thành Phố Hồ Chí Minh. Và cho đến 2023, như một cơ duyên, NGHI đã tham gia chương trình “The MoiSong”, do  và Mixigaming tổ chức.\n\nCô cùng tác phẩm “Nàng” được đón nhận một cách nồng nhiệt và rộng rãi không chỉ tạo cơn sốt trong cộng đồng “Bộ Tộc Mixigaming” mà còn đối với công chúng nói chung. ”Độ hot” của “Nàng” đã đem về hàng trăm nghìn lượt xem và lượt chia sẻ khắp các nền tảng mạng xã hội như Tiktok, Youtube, Facebook,...\n\nNgoài là tác phẩm đầu tay, “Nàng” đánh dấu cho sự trở lại mới lạ và mạnh mẽ của NGHI trên con đường âm nhạc của bản thân.', 'https://images2.imgbox.com/96/17/wgqVJeAl_o.jpg', NULL, '2023', NULL, '2023-12-26 10:19:02'),
	(3, 'Post Malone', '', 'https://images2.imgbox.com/a3/57/rHey6XB7_o.jpg', NULL, '2015', NULL, '2023-12-26 10:38:48'),
	(4, 'RPT MCK', '', 'https://images2.imgbox.com/71/ca/DO01qqI3_o.jpg', NULL, '2020', NULL, '2024-01-02 18:17:10');

-- Dumping structure for table faketify.playlist
DROP TABLE IF EXISTS `playlist`;
CREATE TABLE IF NOT EXISTS `playlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `image` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `playlist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table faketify.playlist: ~4 rows (approximately)
DELETE FROM `playlist`;
INSERT INTO `playlist` (`id`, `user_id`, `name`, `created_at`, `updated_at`, `image`) VALUES
	(1, 2, 'This is Taylor Swift', '2023-12-28 18:03:55', NULL, NULL),
	(2, 2, 'fan MCK 20 nam', '2024-01-02 18:26:41', NULL, NULL),
	(3, 2, 'Moisong', '2024-01-07 12:37:42', NULL, NULL),
	(4, 2, 'Posty', '2024-01-07 12:39:03', NULL, NULL);

-- Dumping structure for table faketify.playlist_song
DROP TABLE IF EXISTS `playlist_song`;
CREATE TABLE IF NOT EXISTS `playlist_song` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `playlist_id` int(11) DEFAULT NULL,
  `song_id` int(11) DEFAULT NULL,
  `position` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `playlist_id` (`playlist_id`),
  KEY `song_id` (`song_id`),
  CONSTRAINT `playlist_song_ibfk_1` FOREIGN KEY (`playlist_id`) REFERENCES `playlist` (`id`),
  CONSTRAINT `playlist_song_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `song` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table faketify.playlist_song: ~29 rows (approximately)
DELETE FROM `playlist_song`;
INSERT INTO `playlist_song` (`id`, `playlist_id`, `song_id`, `position`, `created_at`) VALUES
	(1, 1, 1, 7, '2023-12-28 18:04:21'),
	(2, 1, 2, 8, '2023-12-28 18:04:21'),
	(3, 1, 3, 9, '2023-12-28 18:04:21'),
	(4, 1, 4, 10, '2023-12-28 18:04:21'),
	(5, 1, 5, 2, '2023-12-28 18:04:21'),
	(6, 1, 6, 3, '2023-12-28 18:04:21'),
	(7, 1, 7, 4, '2023-12-28 18:04:21'),
	(8, 1, 8, 5, '2023-12-28 18:04:21'),
	(9, 1, 9, 6, '2023-12-28 18:04:21'),
	(10, 1, 10, 1, '2023-12-28 18:04:21'),
	(11, 2, 18, 1, '2023-12-28 18:04:21'),
	(12, 2, 19, 2, '2023-12-28 18:04:21'),
	(13, 2, 20, 3, '2023-12-28 18:04:21'),
	(14, 2, 21, 4, '2023-12-28 18:04:21'),
	(15, 2, 22, 5, '2023-12-28 18:04:21'),
	(16, 2, 23, 6, '2023-12-28 18:04:21'),
	(17, 2, 24, 7, '2023-12-28 18:04:21'),
	(18, 2, 25, 8, '2023-12-28 18:04:21'),
	(19, 2, 26, 9, '2023-12-28 18:04:21'),
	(20, 2, 27, 10, '2023-12-28 18:04:21'),
	(21, 2, 28, 11, '2023-12-28 18:04:21'),
	(22, 2, 29, 12, '2023-12-28 18:04:21'),
	(23, 2, 30, 13, '2023-12-28 18:04:21'),
	(24, 3, 11, 1, '2023-12-28 18:04:21'),
	(26, 3, 13, 2, '2023-12-28 18:04:21'),
	(27, 4, 14, 1, '2023-12-28 18:04:21'),
	(28, 4, 15, 2, '2023-12-28 18:04:21'),
	(29, 4, 16, 3, '2023-12-28 18:04:21'),
	(30, 4, 17, 4, '2023-12-28 18:04:21');

-- Dumping structure for table faketify.song
DROP TABLE IF EXISTS `song`;
CREATE TABLE IF NOT EXISTS `song` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `artist_id` int(10) unsigned DEFAULT NULL,
  `name` text DEFAULT NULL,
  `s3_file_name` text DEFAULT NULL,
  `s3_key` text DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `source` text DEFAULT NULL,
  `publish_year` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `image` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `artist_id` (`artist_id`),
  CONSTRAINT `song_ibfk_2` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table faketify.song: ~30 rows (approximately)
DELETE FROM `song`;
INSERT INTO `song` (`id`, `artist_id`, `name`, `s3_file_name`, `s3_key`, `duration`, `source`, `publish_year`, `created_at`, `image`) VALUES
	(1, 1, 'Cruel Summer', 'https://faketify.s3.ap-east-1.amazonaws.com/music/01.mp3', '01.mp3', NULL, NULL, 2019, '2023-12-23 23:34:27', NULL),
	(2, 1, 'Lover', 'https://faketify.s3.ap-east-1.amazonaws.com/music/02.mp3', '02.mp3', NULL, NULL, 2019, '2023-12-23 23:34:27', NULL),
	(3, 1, 'The Man', 'https://faketify.s3.ap-east-1.amazonaws.com/music/03.mp3', '03.mp3', NULL, NULL, 2019, '2023-12-26 09:55:05', NULL),
	(4, 1, 'Miss Americana & The Heartbreak Prince', 'https://faketify.s3.ap-east-1.amazonaws.com/music/04.mp3', '04.mp3', NULL, NULL, 2019, '2023-12-26 09:57:44', NULL),
	(5, 1, 'Mine (Taylor\'s Version)', 'https://faketify.s3.ap-east-1.amazonaws.com/music/05.mp3', '05.mp3', NULL, NULL, 2023, '2023-12-26 10:05:13', NULL),
	(6, 1, 'Sparks Fly (Taylor\'s Version)', 'https://faketify.s3.ap-east-1.amazonaws.com/music/06.mp3', '06.mp3', NULL, NULL, 2023, '2023-12-26 10:06:44', NULL),
	(7, 1, 'Back To December (Taylor\'s Version)', 'https://faketify.s3.ap-east-1.amazonaws.com/music/07.mp3', '07.mp3', NULL, NULL, 2023, '2023-12-26 10:07:49', NULL),
	(8, 1, 'Enchanted (Taylor\'s Version)', 'https://faketify.s3.ap-east-1.amazonaws.com/music/08.mp3', '08.mp3', NULL, NULL, 2023, '2023-12-26 10:08:54', NULL),
	(9, 1, 'Long Live (Taylor\'s Version)', 'https://faketify.s3.ap-east-1.amazonaws.com/music/09.mp3', '09.mp3', NULL, NULL, 2023, '2023-12-26 10:09:48', NULL),
	(10, 1, 'Cornelia Street (Live From Paris)', 'https://faketify.s3.ap-east-1.amazonaws.com/music/10.mp3', '10.mp3', NULL, NULL, 2020, '2023-12-26 10:15:27', NULL),
	(11, 2, 'Sau Tấm Rèm', 'https://faketify.s3.ap-east-1.amazonaws.com/music/11.mp3', '11.mp3', NULL, NULL, 2023, '2023-12-26 10:21:40', NULL),
	(12, 2, 'Nàng', 'https://faketify.s3.ap-east-1.amazonaws.com/music/12.mp3', '12.mp3', NULL, NULL, 2023, '2023-12-26 10:26:13', NULL),
	(13, 2, 'Nàng (Story Version)', 'https://faketify.s3.ap-east-1.amazonaws.com/music/13.mp3', '13.mp3', NULL, NULL, 2023, '2023-12-26 10:26:56', NULL),
	(14, 3, 'Hollywood\'s Bleeding', 'https://faketify.s3.ap-east-1.amazonaws.com/music/14.mp3', '14.mp3', NULL, NULL, 2019, '2023-12-26 10:40:27', NULL),
	(15, 3, 'Circles', 'https://faketify.s3.ap-east-1.amazonaws.com/music/15.mp3', '15.mp3', NULL, NULL, 2019, '2023-12-26 10:42:01', NULL),
	(16, 3, 'Sunflower (ft. Swae Lee) (from Spider-Man: Into the Spider-Verse)', 'https://faketify.s3.ap-east-1.amazonaws.com/music/16.mp3', '16.mp3', NULL, NULL, 2019, '2023-12-26 10:42:59', NULL),
	(17, 3, 'Goodbyes (ft. Young Thug)', 'https://faketify.s3.ap-east-1.amazonaws.com/music/17.mp3', '17.mp3', NULL, NULL, 2019, '2023-12-26 10:47:04', NULL),
	(18, 4, 'Chìm Sâu (ft. Trung Trần)', 'https://faketify.s3.ap-east-1.amazonaws.com/music/18.mp3', '18.mp3', NULL, NULL, 2023, '2024-01-02 18:20:25', NULL),
	(19, 4, 'Suit & Tie (ft. Hoàng Tôn)', 'https://faketify.s3.ap-east-1.amazonaws.com/music/19.mp3', '19.mp3', NULL, NULL, 2023, '2024-01-02 18:21:59', NULL),
	(20, 4, 'Va Vào Giai Điệu Này', 'https://faketify.s3.ap-east-1.amazonaws.com/music/20.mp3', '20.mp3', NULL, NULL, 2023, '2024-01-02 18:23:03', NULL),
	(21, 4, 'Tối Nay Ta Đi Đâu Nhờ', 'https://faketify.s3.ap-east-1.amazonaws.com/music/21.mp3', '21.mp3', NULL, NULL, 2023, '2024-01-02 18:23:08', NULL),
	(22, 4, 'Chỉ Một Đêm Nữa Thôi (ft. tlinh)', 'https://faketify.s3.ap-east-1.amazonaws.com/music/22.mp3', '22.mp3', NULL, NULL, 2023, '2024-01-02 18:23:14', NULL),
	(23, 4, 'Thôi Em Đừng Đi (ft. Trung Trần)', 'https://faketify.s3.ap-east-1.amazonaws.com/music/23.mp3', '23.mp3', NULL, NULL, 2023, '2024-01-02 18:23:20', NULL),
	(24, 4, 'Cuốn Cho Anh Một Điếu Nữa Đi', 'https://faketify.s3.ap-east-1.amazonaws.com/music/24.mp3', '24.mp3', NULL, NULL, 2023, '2024-01-02 18:23:25', NULL),
	(25, 4, 'Show Me Love', 'https://faketify.s3.ap-east-1.amazonaws.com/music/25.mp3', '25.mp3', NULL, NULL, 2023, '2024-01-02 18:23:30', NULL),
	(26, 4, 'Tại Vì Sao', 'https://faketify.s3.ap-east-1.amazonaws.com/music/26.mp3', '26.mp3', NULL, NULL, 2023, '2024-01-02 18:23:35', NULL),
	(27, 4, 'Thờ Er', 'https://faketify.s3.ap-east-1.amazonaws.com/music/27.mp3', '27.mp3', NULL, NULL, 2023, '2024-01-02 18:23:42', NULL),
	(28, 4, 'Ai Mới Là Kẻ Xấu Xa', 'https://faketify.s3.ap-east-1.amazonaws.com/music/28.mp3', '28.mp3', NULL, NULL, 2023, '2024-01-02 18:23:48', NULL),
	(29, 4, 'Anh Đã Ổn Hơn', 'https://faketify.s3.ap-east-1.amazonaws.com/music/29.mp3', '29.mp3', NULL, NULL, 2023, '2024-01-02 18:23:52', NULL),
	(30, 4, 'Badtrip', 'https://faketify.s3.ap-east-1.amazonaws.com/music/30.mp3', '30.mp3', NULL, NULL, 2023, '2024-01-02 18:23:58', NULL);

-- Dumping structure for table faketify.user
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `avatar` text DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table faketify.user: ~2 rows (approximately)
DELETE FROM `user`;
INSERT INTO `user` (`id`, `name`, `username`, `phone_number`, `avatar`, `birthday`, `email`, `password`, `created_at`) VALUES
	(1, 'Pham Dinh Quan', 'quan1', NULL, NULL, '2002-12-07', NULL, 'dinhquan', '2023-12-13 04:21:08'),
	(2, 'Tuan Minh Ngo', 'ntm', NULL, NULL, NULL, NULL, 'ntm', '2023-12-13 04:21:32');

-- Dumping structure for table faketify.user_favourite_song
DROP TABLE IF EXISTS `user_favourite_song`;
CREATE TABLE IF NOT EXISTS `user_favourite_song` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `song_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `song_id` (`song_id`),
  CONSTRAINT `user_favourite_song_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `user_favourite_song_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `song` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table faketify.user_favourite_song: ~10 rows (approximately)
DELETE FROM `user_favourite_song`;
INSERT INTO `user_favourite_song` (`id`, `user_id`, `song_id`, `created_at`) VALUES
	(2, 2, 2, '2024-01-02 18:28:51'),
	(3, 2, 8, '2024-01-02 18:28:51'),
	(4, 2, 11, '2024-01-02 18:28:51'),
	(5, 2, 13, '2024-01-02 18:28:51'),
	(6, 2, 15, '2024-01-02 18:28:51'),
	(7, 2, 16, '2024-01-02 18:28:51'),
	(8, 2, 17, '2024-01-02 18:28:51'),
	(9, 2, 22, '2024-01-02 18:28:51'),
	(10, 2, 26, '2024-01-02 18:28:51'),
	(11, 2, 28, '2024-01-02 18:28:51'),
	(12, 2, 29, '2024-01-02 18:28:51');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
