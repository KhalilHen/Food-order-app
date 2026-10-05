import 'package:hf_customer_app/core/custom-widgets/menu_item_detail_modal.dart';
import 'package:hf_customer_app/models/menu_item.dart';
import '../utils/utils.dart';

class CustomMenuItemWidget extends StatefulWidget {
  final MenuItem item;
  const CustomMenuItemWidget({super.key, required this.item});

  @override
  State<CustomMenuItemWidget> createState() => _CustomMenuItemWidgetState();
}

class _CustomMenuItemWidgetState extends State<CustomMenuItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => MenuItemDetailModal(item: widget.item),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Item Image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[300],
                ),
                child:
                    (widget.item.image != null && widget.item.image!.isNotEmpty)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          widget.item.image!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.fastfood,
                                color: Colors.grey,
                                size: 30,
                              ),
                            );
                          },
                        ),
                      )
                    : const Center(
                        child: Icon(
                          Icons.fastfood,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ),
              ),

              const SizedBox(width: 16),

              // Item Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    if (widget.item.description != null &&
                        widget.item.description!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          widget.item.description!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(

                          '€${widget.item.basePrice.toStringAsFixed(2).replaceAll('.', ',')}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.circular(20),
                          ),

                          //TODO Add later that if an item has required customization it opens the modal
                          child: const Text(
                            'Toevoegen',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
