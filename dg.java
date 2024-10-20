import java.util.*;

class DGIM {
    private int windowSize;
    private LinkedList<Bucket> buckets;
    private int currentTime;

    private static class Bucket {
        int timestamp;
        int size;

        Bucket(int timestamp, int size) {
            this.timestamp = timestamp;
            this.size = size;
        }
    }

    public DGIM(int windowSize) {
        this.windowSize = windowSize;
        this.buckets = new LinkedList<>();
        this.currentTime = 0;
    }

    public void update(int bit) {
        currentTime++;
        if (bit == 1) {
            buckets.addFirst(new Bucket(currentTime, 1));
            mergeBuckets();
        }

        if (currentTime > windowSize) {
            removeOldBuckets();
        }
    }

    private void mergeBuckets() {
        int i = 0;
        while (i < buckets.size() - 1) {
            if (buckets.get(i).size == buckets.get(i + 1).size) {
                int newSize = buckets.get(i).size + buckets.get(i + 1).size;
                buckets.set(i, new Bucket(buckets.get(i).timestamp, newSize));
                buckets.remove(i + 1);
            } else {
                i++;
            }
        }
    }

    private void removeOldBuckets() {
        while (!buckets.isEmpty() && buckets.getLast().timestamp <= currentTime - windowSize) {
            buckets.removeLast();
        }
    }

    public int count() {
        int count = 0;
        for (int i = 0; i < buckets.size() - 1; i++) {
            count += buckets.get(i).size;
        }
        if (!buckets.isEmpty()) {
            count += buckets.get(buckets.size() - 1).size / 2;
        }
        return count;
    }
}

public class Main {
    public static void main(String[] args) {
        DGIM dgim = new DGIM(10);
        int[] stream = {1, 0, 1, 1, 1, 0, 1, 0, 0, 1, 1, 0, 1};

        for (int bit : stream) {
            dgim.update(bit);
            System.out.println("Current count: " + dgim.count());
        }
    }
}
