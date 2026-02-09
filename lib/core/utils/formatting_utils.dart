import 'package:flutter/material.dart';

class FormattingUtils {
  /// Format duration in minutes to readable string
  /// Automatically determines if it should show as single duration or range
  /// Examples: "15 minutes", "1 hour 20 minutes", "15-20 minutes"
  static String formatDuration(double minutes) {
    // For small durations, add a small range for better UX
    if (minutes <= 30) {
      final minRange = (minutes * 0.8).round();
      final maxRange = (minutes * 1.2).round();
      return '$minRange-${maxRange} minutes';
    }
    
    // For medium durations (30-120 minutes), show as single duration
    if (minutes <= 120) {
      if (minutes < 60) {
        return '${minutes.toInt()} minutes';
      }
      
      final hours = minutes ~/ 60;
      final mins = minutes % 60;
      
      if (mins == 0) {
        return '$hours ${hours == 1 ? 'hour' : 'hours'}';
      }
      
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ${mins.toInt()} minutes';
    }
    
    // For longer durations, show as range in hours
    final minHours = (minutes * 0.9 / 60).round();
    final maxHours = (minutes * 1.1 / 60).round();
    
    return '$minHours-${maxHours} hours';
  }

  /// Format distance in kilometers
  /// Examples: "2.55 km", "0.5 km"
  static String formatDistance(double km) {
    return '${km.toStringAsFixed(2)} km';
  }

  /// Format price with currency symbol
  /// Examples: "$12.00", "$0.00"
  static String formatPrice(double price, {String currency = '\$'}) {
    return '$currency${price.toStringAsFixed(2)}';
  }

  /// Format phone number (already formatted, just return as is)
  /// But could add formatting logic if needed
  static String formatPhoneNumber(String phone) {
    return phone;
  }

  /// Format order ID with prefix
  /// Example: "#O325"
  static String formatOrderId(String id) {
    return id.startsWith('#') ? id : '#$id';
  }

  /// Get initials from full name
  /// Example: "Mohammed Bassam" -> "MB"
  static String getInitials(String fullName) {
    final parts = fullName.trim().split(' ');
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  /// Capitalize first letter
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// Pluralize word based on count
  static String pluralize(int count, String singular, {String? plural}) {
    if (count == 1) return singular;
    return plural ?? '${singular}s';
  }

  /// Format item count
  /// Example: "4 items", "1 item"
  static String formatItemCount(int count) {
    return '$count ${pluralize(count, 'item')}';
  }
}

/// Extension on Color to add alpha percentage functionality
extension ColorAlphaPercent on Color {
  /// Create a new Color with the specified alpha percentage
  /// 
  /// Takes a percentage value (0.0 to 1.0) and applies it as the alpha channel
  /// to create a new Color with the specified opacity level.
  /// 
  /// Examples:
  /// - Colors.red.withAlphaPercent(1.0) -> Fully opaque red
  /// - Colors.blue.withAlphaPercent(0.5) -> 50% transparent blue
  /// - Colors.black.withAlphaPercent(0.0) -> Fully transparent black
  /// 
  /// @param percentage The alpha percentage as a decimal (0.0 to 1.0)
  /// @return A new Color with the specified alpha value
  Color withAlphaPercent(double percentage) {
     final clampedPercentage = percentage.clamp(0.0, 1.0);
    // Convert to 0-255 range and round to nearest integer
    final alpha = (clampedPercentage * 255).round();
    return withAlpha(alpha);
  }
}
