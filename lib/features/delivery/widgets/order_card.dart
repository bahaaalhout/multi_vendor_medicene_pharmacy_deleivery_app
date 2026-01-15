import 'package:flutter/material.dart';
import 'address_row.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final String pharmacy;
  final String rating;
  final String fromTitle;
  final String fromSubtitle;
  final String toTitle;
  final String toSubtitle;
  final String time;
  final String distance;
  final String? badge;
  final String? price;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.pharmacy,
    required this.rating,
    required this.fromTitle,
    required this.fromSubtitle,
    required this.toTitle,
    required this.toSubtitle,
    required this.time,
    required this.distance,
    this.badge,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFC0C8E5)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Order ID: $orderId",
                  style: const TextStyle(color: Color(0xFFA29E9D)),
                ),
              ),
              const Text("Copy", style: TextStyle(color: Color(0xFFA29E9D))),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFEBEDF7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.local_pharmacy,
                    color: Color(0xFF334EAC)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  pharmacy,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF263B81)),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F6F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star,
                        size: 16, color: Color(0xFFFFCC00)),
                    const SizedBox(width: 4),
                    Text(rating),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          AddressRow("From", fromTitle, fromSubtitle),
          const SizedBox(height: 8),
          AddressRow("To", toTitle, toSubtitle),
          const SizedBox(height: 12),
          Row(
            children: [
              InfoChip(Icons.timer, time),
              const SizedBox(width: 8),
              InfoChip(Icons.route, distance),
              const Spacer(),
              if (badge != null)
                Chip(
                  backgroundColor: const Color(0xFFE1F7E6),
                  label: Text(badge!,
                      style:
                          const TextStyle(color: Color(0xFF12461F))),
                ),
              if (price != null)
                Text(price!,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F7735))),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF17234D),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {},
              child: const Text("Accept Order"),
            ),
          )
        ],
      ),
    );
  }
}

class InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoChip(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFCAC6C4)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
