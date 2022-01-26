import 'dart:io';

import 'package:flutter_fast_lib/src/util/fast_log_util.dart';
import 'package:path_provider/path_provider.dart';

///缓存相关处理工具类--Android常用默认[getTemporaryDirectory]
class FastCacheUtil {
  ///所有需要计算文件夹
  static final List<Directory> _listDirectory = [];

  ///添加其它需要计算文件夹
  static addDirectory(Directory directory) async {
    ///不存在--根据路径判断是否为同一文件夹
    if (directory.existsSync() &&
        _listDirectory.every((element) {
          return element.path != directory.path;
        })) {
      _listDirectory.add(directory);
    }
  }

  ///移除其它需要计算文件夹
  static Future<bool> removeDirectory(Directory directory) async {
    ///存在路径相同
    _listDirectory.removeWhere(
        (element) => directory.existsSync() && element.path == directory.path);
    return true;
  }

  ///加载缓存
  static Future<double> loadCache() async {
    ///增加默认缓存文件夹
    addDirectory(await getTemporaryDirectory());
    FastLogUtil.e('size:${_listDirectory.length}', tag: 'FastCacheUtil');
    double totalSize = 0.0;
    for (int i = 0; i < _listDirectory.length; i++) {
      double _currentSize = await _loadCache(_listDirectory[i]);
      FastLogUtil.e(
          '${_listDirectory[i].path};size:${renderSize(_currentSize).toLowerCase()}',
          tag: 'FastCacheUtil');
      totalSize += _currentSize;
    }
    return totalSize;
  }

  ///获取缓存并格式返回
  /// toLowerCase 是否小写默认大写
  static Future<String> loadCacheRenderSize({
    bool toLowerCase = false,
  }) async {
    String result = renderSize(await loadCache());
    if (toLowerCase) {
      return result.toLowerCase();
    }
    return result;
  }

  ///根据文件夹path获取所有文件占用空间
  static Future<double> _loadCache(Directory directory) async {
    try {
      return await _getTotalSizeOfFilesInDir(directory);
    } catch (err) {
      return 0.0;
    }
  }

  /// 递归方式 计算文件的大小
  static Future<double> _getTotalSizeOfFilesInDir(FileSystemEntity file) async {
    try {
      if (file is File) {
        int length = await file.length();
        return length.toDouble();
      }
      if (file is Directory) {
        List<FileSystemEntity> children = file.listSync();
        double total = 0;
        if (children.isNotEmpty) {
          for (FileSystemEntity child in children) {
            total += await _getTotalSizeOfFilesInDir(child);
          }
        }
        return total;
      }
      return 0;
    } catch (e) {
      FastLogUtil.e('_getTotalSizeOfFilesInDir:$e', tag: 'FastCacheUtil');
      return 0;
    }
  }

  ///格式化文件大小
  static String renderSize(double value) {
    List<String> unitArr = ['B', 'KB', 'MB', 'GB'];
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }

  ///清理缓存
  static Future<bool> clearCache() async {
    ///此处展示加载loading
    try {
      for (int i = 0; i < _listDirectory.length; i++) {
        await _delDir(_listDirectory[i]);
      }
      return await loadCache() <= 0;
    } catch (e) {
      FastLogUtil.e('clearCache:$e', tag: 'FastCacheUtil');
      return false;
    }
  }

  ///递归方式删除目录
  static Future _delDir(FileSystemEntity file) async {
    try {
      if (file is Directory) {
        List<FileSystemEntity> children = file.listSync();
        for (FileSystemEntity child in children) {
          await _delDir(child);
        }
      }
      await file.delete();
    } catch (e) {
      FastLogUtil.e('_delDir:$e', tag: 'FastCacheUtil');
    }
  }
}
