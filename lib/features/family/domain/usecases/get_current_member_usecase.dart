import '../../../../core/error/api_result.dart';
import '../entities/family_member_entity.dart';
import '../repos/family_repository.dart';

class GetCurrentMemberUseCase {
  final FamilyRepository _repository;

  GetCurrentMemberUseCase(this._repository);

  Future<ApiResult<FamilyMemberEntity?>> call() =>
      _repository.getCurrentMember();
}
