<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags"%>
<a:html title=" - Group Action Test : List"
	contents="${param.contents }">
<h1>강의를 선택해주세요</h1>
	<ul data-role="listview" data-split-icon="check" data-split-theme="d" data-filter="true" 
	data-filter-placeholder="Search Lecture... " data-filter-theme="c" data-theme="g" data-divider-theme="b">
		<s:iterator value="listData">
			<li><a href="/lectureEvaluation/profshow?id=${id }">${name }</a></li>
		</s:iterator>
			<%-- <li><a:pagenav page="${param.page }" params="${params}" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" cssClass="page-controller" font="symbol" /></li> --%>
	</ul>
<%-- 			
			
			
			
			
			
			
			
			
			
			
			
			
			<table class="artn-board list" data-role="table" id="movie-table" data-mode="reflow" class="ui-responsive">
				<thead>
					<tr>
						<th>강의명</th>
						<th>시작/종료날짜</th>
						<th>강의/실습요일</th>
						<th>강의시작/종료시간</th>
						<th>실습시작/종료시간</th>
						<th>정보</th>
						<th>목록</th>
						<th>기타</th>
					</tr>
				</thead>

				<tbody>
					<s:if test="listIsNull">
						<tr>
							<td colspan="7">그룹이 없습니다 ^^;</td>
						</tr>
					</s:if>
					<s:else>
						<s:iterator value="listData">
							<tr>
								<td>${row_number }</td>
								<td>${name }</td>
								<td>${date_start }/${date_end }</td>
								<td>${weekly_lect }/${weekly_prtc }</td>
								<td>${time_lect_start }/${time_lect_end }</td>
								<td>${time_prtc_start }/${time_prtc_end }</td>
								<td><a href="show?id=${id }">정보 보기</a></td>
								<td><a href="/groupuser/list?id_group=${id }">목록 보기</a></td>
								<td><a href="/groupuser/edit?id_group=${id }">그룹 회원 추가</a></td>
							</tr>
						</s:iterator>
					</s:else>
				</tbody>
			</table> --%>
			
			
			<%-- <a:pagenav page="${param.page }" rowCount="${rowCount }"
				rowLimit="10" navCount="10" id="pagecontroller" /> --%>

</a:html>