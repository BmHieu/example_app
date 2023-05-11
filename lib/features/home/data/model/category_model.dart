class Job {
  int id;
  String image;
  String jobName;

  Job({
    required this.id,
    required this.image,
    required this.jobName,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'] as int,
      image: json['image'] as String,
      jobName: json['job_name'] as String,
    );
  }
}

class JobGroup {
  int id;
  String major;
  List<Job> careers;

  JobGroup({
    required this.id,
    required this.major,
    required this.careers,
  });

  factory JobGroup.fromJson(Map<String, dynamic> json) {
    return JobGroup(
      id: json['id'],
      major: json['major'],
      careers: (json['careers'] as List)
          .map((e) => Job.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
