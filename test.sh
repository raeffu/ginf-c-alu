make alu-main
cat ./src/test/alu-test.txt | ./alu-main > test-results.txt
diff -u ./src/test/alu-test-results.txt test-results.txt | head -n 20
