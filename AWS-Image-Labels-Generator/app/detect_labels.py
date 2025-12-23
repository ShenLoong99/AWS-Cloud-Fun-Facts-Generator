import boto3
import matplotlib.pyplot as plt
from PIL import Image
import io
import os

# =========================
# CONFIGURATION
# =========================
BUCKET_NAME = os.environ["S3_BUCKET_NAME"]  # S3 Bucket name
IMAGE_NAME  = "busy-traffic-road.jpg"       # Image uploaded to S3
MIN_CONFIDENCE = 70                         # Confidence threshold (%)

# =========================
# AWS CLIENT
# =========================
rekognition = boto3.client("rekognition")
s3 = boto3.client("s3")

# =========================
# LOAD IMAGE FROM S3
# =========================
s3_response = s3.get_object(
    Bucket=BUCKET_NAME,
    Key=IMAGE_NAME
)

image_bytes = s3_response["Body"].read()
image = Image.open(io.BytesIO(image_bytes))
img_width, img_height = image.size

# =========================
# CALL REKOGNITION
# =========================
response = rekognition.detect_labels(
    Image={
        "S3Object": {
            "Bucket": BUCKET_NAME,
            "Name": IMAGE_NAME
        }
    },
    MaxLabels=10,
    MinConfidence=MIN_CONFIDENCE
)

# =========================
# DRAW BOUNDING BOXES
# =========================
plt.figure(figsize=(10, 8))
plt.imshow(image)
ax = plt.gca()

for label in response["Labels"]:
    label_name = label["Name"]
    confidence = label["Confidence"]

    for instance in label.get("Instances", []):
        bbox = instance.get("BoundingBox")
        if not bbox:
            continue

        left   = bbox["Left"] * img_width
        top    = bbox["Top"] * img_height
        width  = bbox["Width"] * img_width
        height = bbox["Height"] * img_height

        # Draw rectangle
        rect = plt.Rectangle(
            (left, top),
            width,
            height,
            fill=False,
            edgecolor="red",
            linewidth=2
        )
        ax.add_patch(rect)

        # Draw label text
        ax.text(
            left,
            top - 5,
            f"{label_name} ({confidence:.1f}%)",
            color="red",
            fontsize=10,
            bbox=dict(facecolor="white", alpha=0.7)
        )

# =========================
# FINAL DISPLAY
# =========================
plt.axis("off")
plt.title("Amazon Rekognition – Detected Labels")
plt.show()

# =========================
# PRINT LABEL SUMMARY
# =========================
print("\nDetected Labels:\n")
for label in response["Labels"]:
    print(f"- {label['Name']} ({label['Confidence']:.2f}%)")
