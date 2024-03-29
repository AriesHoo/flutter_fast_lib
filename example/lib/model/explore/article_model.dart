import 'package:flutter_fast_lib/flutter_fast_lib.dart';

///Readhub 文章item model
class ArticleModel {
  List<ArticleItemModel>? data;
  int? pageSize;
  int? totalItems;
  int? totalPages;

  ArticleModel({this.data, this.pageSize, this.totalItems, this.totalPages});

  String getLastCursor() {
    return data == null ? "" : data![data!.length - 1].getLastCursor();
  }

  ArticleModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        ArticleItemModel item = ArticleItemModel.fromJson(v);
        item.parseTimeLong();
        data!.add(item);
      });
    }
    pageSize = json['pageSize'];
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['pageSize'] = pageSize;
    data['totalItems'] = totalItems;
    data['totalPages'] = totalPages;
    return data;
  }
}

class ArticleItemModel {
  String? id;
  List<NewsArray>? newsArray;
  String? createdAt;
  List<EventData>? eventData;
  String? publishDate;
  String? summary;
  String? summaryAuto;
  String? title;
  String? updatedAt;
  String? timeline;
  int? order;
  bool? hasInstantView;
  Extra? extra;
  bool maxLine = true;

  ///时间戳-utc时间
  int publishTime = 0;
  String timeStr = "";
  String? siteName;
  String? authorName;
  String? url;
  String? mobileUrl;
  String? language = '';
  String timeFormatStr = '';

  ///热点新闻
  bool isTopic = false;

  String getUrl({
    bool showUrl = true,
  }) {
    if (isTopic && showUrl) {
      return 'https://readhub.cn/topic/$id';
    }
    return mobileUrl ??
        url ??
        (newsArray != null && newsArray!.isNotEmpty
            ? newsArray![0].getUrl()
            : "");
  }

  ///大于1才显示
  bool showLink() {
    return false;
  }

  String? getFileName() {
    return TextUtil.isEmpty(id) ? publishTime.toString().trim() : id;
  }

  ///扫码提示
  String getScanNote() {
    String str = "";
    if (siteName == null || siteName!.isEmpty) {
      if (newsArray != null) {
        NewsArray item = newsArray![0];
        str = newsArray!.length > 1
            ? '${item.siteName} 等 ${newsArray!.length} 家媒体报道'
            : '来自 ${item.siteName} 的报道';
      }
    } else {
      str = '来自 $siteName 的报道';
    }
    return "$str\n扫码查看详情";
  }

  String getSummary() {
    String? back = summaryAuto ?? summary;
    if (back != null && back.isNotEmpty) {
      return back;
    }
    return language != null && language!.contains('en')
        ? 'There is no summary of this report. please check the details'
        : '本篇报道暂无摘要，请查看详细信息。';
  }

  ///获取媒体及发布时间
  String getTimeStr() {
    parseTimeLong();
    String back = timeStr;
    if (siteName != null && siteName!.isNotEmpty) {
      if (authorName != null && authorName!.isNotEmpty) {
        back = '$siteName / $authorName    $timeStr';
      } else {
        back = '$siteName $timeStr';
      }
    } else {
      if (newsArray != null) {
        NewsArray item = newsArray![0];
        back =
            '${newsArray!.length > 1 ? item.siteName : item.siteName} $timeStr';
      }
    }
    return back;
  }

  ///时间转换
  void parseTimeLong() {
    String targetTime = createdAt == null ? publishDate! : createdAt!;
    try {
      String time =
          targetTime.replaceAll("Z", "").replaceAll("T", " ").substring(0, 19);

      ///因服务返回时间为UTC时间--即0时区时间且将本地时间同步转换为utc/local时间即可算出时间差
      DateTime createTime = DateTime.parse("$time+00:00").toLocal();
      DateTime nowTime = DateTime.now().toLocal();
      Duration hourDiff = nowTime.difference(createTime);
      int dayDiff = nowTime.day - createTime.day;

      ///如果有天数差-此处是重点应该是以天数差作为昨天/前天 几天前标志而不是24小时
      if (dayDiff > 0) {
        if (dayDiff == 1) {
          timeStr = "昨天";
        } else if (dayDiff == 2) {
          timeStr = "前天";
        } else {
          timeStr = "$dayDiff天前";
        }
      } else if (hourDiff.inDays > 0) {
        if (hourDiff.inDays == 1) {
          timeStr = "昨天";
        } else if (hourDiff.inDays == 2) {
          timeStr = "前天";
        } else {
          timeStr = " ${hourDiff.inDays}天前";
        }
      } else if (hourDiff.inHours > 0) {
        ///此处做了取整-readhub官方亦是如此操作
        timeStr =
            " ${hourDiff.inHours + (hourDiff.inMinutes % 60 >= 30 ? 1 : 0)}小时前";
      } else if (hourDiff.inMinutes > 0) {
        timeStr = " ${hourDiff.inMinutes}分钟前";
      } else {
        timeStr = "刚刚";
      }
      timeFormatStr = createTime
          .toLocal()
          .toIso8601String()
          .replaceAll("T", " ")
          .substring(5, 16);
    } catch (e) {
      FastLogUtil.v("parseTimeLong:$e");
    }
    try {
      String time = publishDate!
          .replaceAll("Z", "")
          .replaceAll("T", " ")
          .substring(0, 19);
      DateTime dateTime = DateTime.parse("$time+00:00").toUtc();
      publishTime = dateTime.millisecondsSinceEpoch;
    } catch (e) {
      FastLogUtil.e('e$e');
    }
  }

  String getLastCursor() {
    if (order != null) {
      return order.toString();
    }
    return publishTime.toString();
  }

  switchMaxLine() {
    maxLine = !maxLine;
  }

  ArticleItemModel(
      {this.id,
      this.newsArray,
      this.createdAt,
      this.eventData,
      this.publishDate,
      this.summary,
      this.title,
      this.updatedAt,
      this.timeline,
      this.order,
      this.hasInstantView,
      this.language,
      this.extra});

  ArticleItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    if (json['newsArray'] != null) {
      newsArray = [];
      json['newsArray'].forEach((v) {
        newsArray!.add(NewsArray.fromJson(v));
      });
    }
    createdAt = json['createdAt']?.trim();
    if (json['eventData'] != null) {
      eventData = [];
      json['eventData'].forEach((v) {
        eventData!.add(EventData.fromJson(v));
      });
    }
    siteName = json['siteName']?.trim();
    authorName = json['authorName']?.trim();
    url = json['url']?.trim();
    mobileUrl = json['mobileUrl']?.trim();
    summaryAuto = json['summaryAuto']?.trim();
    language = json['language']?.trim();
    publishDate = json['publishDate']?.trim();
    summary = json['summary']?.trim();
    title = json['title']?.trim();
    updatedAt = json['updatedAt']?.trim();
    timeline = json['timeline']?.trim();
    order = json['order'];
    hasInstantView = json['hasInstantView'];
    extra = json['extra'] != null ? Extra.fromJson(json['extra']) : null;

    if (newsArray != null && newsArray!.isNotEmpty) {
      for (var item in newsArray!) {
        item.summary = summary;
        item.summaryAuto = summaryAuto;
      }
    }
    try {
      int.parse(id!);
    } catch (e) {
      isTopic = true;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (newsArray != null) {
      data['newsArray'] = newsArray!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    if (eventData != null) {
      data['eventData'] = eventData!.map((v) => v.toJson()).toList();
    }
    data['publishDate'] = publishDate;
    data['summary'] = summary;
    data['title'] = title;
    data['updatedAt'] = updatedAt;
    data['timeline'] = timeline;
    data['order'] = order;
    data['hasInstantView'] = hasInstantView;
    if (extra != null) {
      data['extra'] = extra!.toJson();
    }
    return data;
  }
}

class NewsArray {
  int? id;
  String? url;
  String? title;
  String? siteName;
  String? mobileUrl;
  String? autherName;
  int? duplicateId;
  String? publishDate;
  String? language;
  int? statementType;
  String? timeStr;
  String? summary;
  String? summaryAuto;

  ///时间转换
  String? parseTimeLong() {
    if (timeStr != null && timeStr!.isNotEmpty) {
      return timeStr;
    }
    String targetTime = publishDate!;
    try {
      String time =
          targetTime.replaceAll("Z", "").replaceAll("T", " ").substring(0, 19);

      ///因服务返回时间为UTC时间--即0时区时间将时间转换为本地时间即可正常显示
      DateTime createTime = DateTime.parse("$time+00:00").toLocal();
      timeStr =
          createTime.toIso8601String().replaceAll("T", " ").substring(5, 16);
    } catch (e) {
      FastLogUtil.v("parseTimeLong:$e");
    }
    return timeStr;
  }

  String getUrl() {
    return mobileUrl ?? url ?? "";
  }

  ///扫码提示
  String getScanNote() {
    String str = "";
    if (siteName != null || siteName!.isEmpty) {
      str = '来自 $siteName 的报道';
    }
    return "$str\n扫码查看详情";
  }

  String getSummary() {
    String? back = summaryAuto ?? summary;
    if (back != null && back.isNotEmpty) {
      return back;
    }
    return language != null && language!.contains('en')
        ? 'There is no summary of this report. please check the details'
        : '本篇报道暂无摘要，请查看详细信息。';
  }

  NewsArray(
      {this.id,
      this.url,
      this.title,
      this.siteName,
      this.mobileUrl,
      this.autherName,
      this.duplicateId,
      this.publishDate,
      this.language,
      this.statementType});

  NewsArray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url']?.trim();
    title = json['title']?.trim();
    siteName = json['siteName']?.trim();
    mobileUrl = json['mobileUrl']?.trim();
    autherName = json['autherName']?.trim();
    duplicateId = json['duplicateId'];
    publishDate = json['publishDate'];
    language = json['language']?.trim();
    statementType = json['statementType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['title'] = title;
    data['siteName'] = siteName;
    data['mobileUrl'] = mobileUrl;
    data['autherName'] = autherName;
    data['duplicateId'] = duplicateId;
    data['publishDate'] = publishDate;
    data['language'] = language;
    data['statementType'] = statementType;
    return data;
  }
}

class EventData {
  int? id;
  String? topicId;
  int? eventType;
  String? entityId;
  String? entityType;
  String? entityName;
  int? state;
  String? createdAt;
  String? updatedAt;

  EventData(
      {this.id,
      this.topicId,
      this.eventType,
      this.entityId,
      this.entityType,
      this.entityName,
      this.state,
      this.createdAt,
      this.updatedAt});

  EventData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topicId = json['topicId'];
    eventType = json['eventType'];
    entityId = json['entityId'];
    entityType = json['entityType'];
    entityName = json['entityName'];
    state = json['state'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['topicId'] = topicId;
    data['eventType'] = eventType;
    data['entityId'] = entityId;
    data['entityType'] = entityType;
    data['entityName'] = entityName;
    data['state'] = state;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Extra {
  bool? instantView;

  Extra({this.instantView});

  Extra.fromJson(Map<String, dynamic> json) {
    instantView = json['instantView'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['instantView'] = instantView;
    return data;
  }
}
